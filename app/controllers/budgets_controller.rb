class BudgetsController < ApplicationController
  before_action :find_budget, :login_check
  before_action :permission_check, except: :create

  def show
    @months = @budget.months.order(month_date: :desc)
    Month.make_current_month(@budget.id) if @months.empty?
    # UserMailer.hello_user(@budget.user).deliver_now #works!!!
    # UserMailer.update_actuals.deliver_now #works!!!
    @months.each do |month|
      month.calc_actuals
      month.calc_projected
      # @goals = @budget.goals
    end
    # exist = @months.any? {|m| m.month_date.year == Date.today.year && m.month_date.month == Date.today.month} 
    # Month.make_current_month(@budget.id) unless exist
  end

  def bar_chart
    months = @budget.months
    expa = []
    inca = []
    expp = []
    incp = []
    months.each do |month|
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
