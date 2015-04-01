class UsersController < ApplicationController
  before_action :login_check, only: [:show, :edit, :update]
  before_action :find_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes user_params
      redirect_to @user, notice: "Your user details have been updated"
    else
      redirect_to :back, notice: "Updated failed: Please review form"
    end
  end

#do we really want this functionality?
  # def destroy
  #   @user.destroy
  #   redirect_to '/', notice: "@user.fullname has been deleted"
  # end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday, :cell_num, :email)
  end

  def find_user
    @user = User.find(params[:id])
  end

#Checks to make sure the user making a change is the owner of the resource.
  def login_check
    redirect_to '/', notice: "Please sign in" unless current_user
    redirect_to '/', notice: "Permission to alter this record denied" unless current_user == User.find(params[:id])
  end
end
