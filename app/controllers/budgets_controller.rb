class BudgetsController < ApplicationController
  before_action :find_budget, :login_check

  def show
    @months = @budget.months
    @months.each do |month|
      month.calc_actuals
      month.calc_projected
    end
    # exist = @months.any? {|m| m.month_date.year == Date.today.year && m.month_date.month == Date.today.month} 
    # Month.make_current_month(@budget.id) unless exist
  end

  def bar_chart
    months = @budget.months
    exp = []
    income = []
    months.each do |month|
      month.calc_actuals
      month.calc_projected
      exp << [month.month_date.month.to_i, month.actual_exp.to_i]
      income << [month.month_date.month.to_i, month.actual_income.to_i]
    end
    respond_to do |format|
        format.json {render :json => {income: income, expense: exp}}
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
end
