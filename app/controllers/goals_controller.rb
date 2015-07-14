class GoalsController < ApplicationController
  def index
    @budget = Budget.find params[:budget_id]
    @goals = @budget.goals
    @t = Time.new( Time.now.year, Time.now.month)
    @earliest = @budget.earliest_goal
    @goals_inc_progress = "#{(@budget.goals_progress('income') * 100).round(1)}% actual savings toward target."
    @goals_exp_progress = "#{(@budget.goals_progress('expense') * 100).round(1)} of target expanses spent"
  end

  def show
    @goal = Goal.find params[:id]
    @cats = @goal.categories #categories associated with this goal
    @total = @cats.reduce(0) {|s, c| s + c.actuals}
    
  end

  def create
    budget = Budget.find params[:budget_id]
    goal = Goal.new goal_params
    goal.budget = budget

    sd = goal_params[:start_date].partition('-')
    ed = goal_params[:end_date].partition('-')
    
    goal.start_date = Date.new(sd[0].to_i, sd[2].to_i)
    goal.end_date = Date.new(ed[0].to_i, ed[2].to_i)
    t = Date.today #storing current time
    t1 = Date.new(t.month > 1 ? t.year + 1 : t.year, t.month) # a year out from today
    date_range = [(Date.new( t.year, t.month) - 3600), t1 ]
    
    if goal.start_date < date_range[0] || goal.start_date > date_range[1] || goal.end_date >= date_range[1] #ensures that goals timeline are at most one year from current month
      redirect_to :back, notice:"Your goal dates are out of the one year range from today" 
      return
    end

    if goal.save
      goal.make_plans
      redirect_to goal, notice: "New goal-#{goal.name} has been added!"
    else
      # binding.pry
      redirect_to :back, notice: "Goal not added, please review the goal form"
    end
  end

  def update
    goal = Goal.find params[:id]
    g1 = [goal.target_value, goal.end_date]
    p_ed = goal_params[:end_date].concat("-1").to_date
    if p_ed > goal.start_date.advance(years: +1) || p_ed < goal.start_date
      redirect_to :back, notice: "End date must be within 12 months of start date"
      return
    end

    goal.update_attributes goal_params
    goal.end_date = p_ed
    goal.target_value = goal_params[:target_value].to_i
    goal.save
    unless g1[1] == goal.end_date
      goal.extend_time(g1[1]) if g1[1] < goal.end_date
      goal.dec_time if g1[1] > goal.end_date
    end
    unless g1[0] == goal.target_value
      cats = goal.categories
      cats.each do|c| 
        c1 = Category.find c.id
        c1.proj_val = (goal.target_value / cats.length)
        c1.save
      end
    end
    goal.save
    redirect_to goal, notice: "Goal Updated Successfully"
  end

  def destroy
    #find goal and get the months associated with it
    #find categories connected to the goal and destroy them
    #Finally destroy the goal, which will destroy the plan
    goal = Goal.find params[:id]
    # goal. categories
    goal.destroy
    redirect_to budget_goals_path(goal.budget)
  end

  private
  def goal_params
    params.require(:goal).permit(:name, :start_date, :end_date, :category, :is_expense, :operator, :target_value)
  end

  def login_check
    redirect_to new_user_session_path, notice: "Please sign in" unless current_user  
  end

  def permission_check
    redirect_to root_path, notice: "Permission Denied" if current_user.id != Budget.find(params[:budget_id]).user.id
  end
end
