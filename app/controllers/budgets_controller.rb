class BudgetsController < ApplicationController
  before_action :find_budget, :login_check
  before_action :permission_check, except: :create

  def show
    @months = @budget.months.order(month_date: :desc)
    Month.make_current_month(@budget.id) if @months.empty?
    @goals_ending = @budget.goals_ending
    @months.each do |month|
      month.calc_actuals
      month.calc_projected
    end
    @goals = @budget.goals
    

  end

  def bar_chart
    months = @budget.months
    expa = []
    inca = []
    expp = []
    incp = []
    months_filter = [Date.today - 365, Date.today + 365]
    months.each do |month|
      return if month.month_date < months_filter[0] || month.month_date > months_filter[1]
      month.calc_actuals
      month.calc_projected
      expa << [month.month_date.month.to_i, month.actual_exp.to_i]
      inca << [month.month_date.month.to_i, month.actual_income.to_i]
      expp << [month.month_date.month.to_i, month.projected_exp.to_i]
      incp << [month.month_date.month.to_i, month.projected_income.to_i]
    end
    respond_to do |format|
        format.json {render :json => {incomep: incp, expensep: expp, incomea: inca, expensea: expa}}
    end
  end

  def edit
  end

  def update
    if @budget.update_attributes budget_params
      flash[:success] = "Success: Budget updated"
      redirect_to @budget
    else
      redirect_to :back, alert: "Update failed, a budget reqires a name"
    end
  end

  private
  def budget_params
    params.require(:budget).permit(:name, :desc)
  end

  def find_budget
    @budget = Budget.find params[:id]
    @user = @budget.user
  end

  def login_check
    redirect_to new_user_session_path, notice: "Please sign in" unless current_user
    
  end
  def permission_check
    redirect_to root_path, notice: "Permission Denied" if current_user.id != Budget.find(params[:id]).user.id
  end
end
