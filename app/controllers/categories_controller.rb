class CategoriesController < ApplicationController
  before_action :login_check

  def index
  end

  def edit
  end

  def create
    category = Category.new category_params
    if category.save
      category.month = Month.find params[:month_id]
      category.save
      flash[:success] = "New category added"
      redirect_to category.month
    else
      redirect_to :back, notice: "failed to create category, please review form"
    end
  end

  def update
    category = Category.find(params[:id])
    if category.update_attributes category_params
      category.month.save
      respond_to do |format|
        format.html {}
        format.json {render :json => category}
      end
      # flash[:success] = "#{category.name} updated"
      # redirect_to category.month
    else
      respond_to do |format|
        format.html {}
        format.json {render :json => category}
      end
      # redirect_to :back, notice: "category update failed, please review form"
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to category.month, notice: "#{category.name} deleted"
  end

  private
  def category_params
    params.require(:category).permit(:name, :expense, :desc, :proj_val, :period1, :period2, :period3, :period4)
  end

  def login_check
    redirect_to new_user_session_path, notice: "Please sign in" unless current_user
    redirect_to root_path, notice: "Permission Denied" if current_user.budget.id != Category.find(params[:id]).month.budget.id
  end
end
