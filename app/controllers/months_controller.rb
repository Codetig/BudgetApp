class MonthsController < ApplicationController
  before_action :login_check
  before_action :permission_check, :find_month, except: [:new, :create]
  def new
    @budget = Budget.find params[:budget_id]
  end

  def show
    @categories = @month.categories.order(:id)
    Category.make_defaults(@month) if @categories.empty?
    @expenses = []
    @income = []
    @categories.each do |cat|
      if cat.expense
        @expenses << cat
      else
        @income << cat
      end
    end
  end

  def edit
  end

  def pie_chart
    categories = @month.categories.order(:id)
    exp = []
    income = []
    unless categories.empty?
      categories.each do |cat|
          exp << [cat.name, cat.proj_val] if cat.expense
          income << [cat.name, cat.proj_val] unless cat.expense
      end
      respond_to do |format|
        format.json {render json: {expense: exp, income: income}}
      end
    else
      respond_to do |format|
        format.json {render json: nil}
      end
    end
  end

  def create
    month = Month.new month_params
    month.projected_income ||= 0
    month.projected_exp ||= 0
    month.actual_income ||= 0
    month.actual_exp ||= 0
    
    if !month.month_exists? && month.save
      month.budget = current_user.budget
      month.save
      flash[:success] = "Success: Month created"
      redirect_to month
    else
      flash[:alert] = "The month you attempted to create already exists" if month.month_exists?
      redirect_to :back, notice: "Please review your form below"
    end

  end

  def update
    #making sure duplicates are not added using edit
    if @month.month_date.year != month_params[:month_date].to_date.year && @month.month_date.month != month_params[:month_date].to_date.month 
      @month.month_date = params[:month_date]
      redirect_to :back, notice: "The date matches an existing month" if @month.month_exists?
    end

    if @month.update_attributes month_params
      redirect_to @month, notice: "Success: #{@month.name} updated"
    else
      redirect_to :back, notice: "Failed to update, please review your form below"
    end
  end

  def destroy
    @month.destroy
    redirect_to @month.budget, notice: "#{@month.name} has been deleted"
  end

  private
  def month_params
    params.require(:month).permit(:month_date, :name, :projected_income, :projected_exp, :actual_income, :actual_exp)
  end
  def login_check
    redirect_to new_user_session_path, notice: "Please sign in" unless current_user
    
  end

  def permission_check
    redirect_to root_path, notice: "Permission Denied" if current_user.id != Month.find(params[:id]).budget.user.id
  end

  def find_month
    @month = Month.find params[:id]
  end
end
