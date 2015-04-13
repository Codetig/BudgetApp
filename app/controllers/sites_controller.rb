class SitesController < ApplicationController

  def home
    login_check
  end

  private
  def login_check
    if current_user
      current_user.gen_budget unless current_user.budget
      redirect_to current_user.budget || root_path
    end
  end
end
