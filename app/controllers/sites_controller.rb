class SitesController < ApplicationController

  def home
    login_check
  end

  private
  def login_check
    if current_user
      Budget.create(name:"#{current_user.first_name}'s Budget", user_id: current_user.id) unless current_user.budget
    end
    redirect_to current_user.budget if current_user
  end
end
