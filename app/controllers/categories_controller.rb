class CategoriesController < ApplicationController
  before_action :login_check
  before_action :permission_check, except: :create

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
    goal_str = 'Goal ' if category.goal
    if category.update_attributes category_params
      if goal_str && !category.name.include?('Goal')
        category.name.prepend(goal_str)
        # category.save
      end
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
        format.json {render :json => {:errors => category.errors.full_messages}, :status => 406}
      end
      # redirect_to :back, notice: "category update failed, please review form"
    end
  end

  def destroy
    category = Category.find(params[:id])
    if category.goal
      redirect_to :back, notice: "Delete Failed: Goal generated categoriess can only be deleted by deleting the goal that generated them."
      return
    end

    category.destroy
    redirect_to category.month, notice: "#{category.name} deleted"
  end

  private
  def category_params
    params.require(:category).permit(:name, :expense, :desc, :proj_val, :period1, :period2, :period3, :period4)
  end

  def login_check
    redirect_to new_user_session_path, notice: "Please sign in" unless current_user
    
  end

  def permission_check
    redirect_to root_path, notice: "Permission Denied" if current_user.budget.id != Category.find(params[:id]).month.budget.id
  end

end
