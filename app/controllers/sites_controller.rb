class SitesController < ApplicationController

  def home
    login_check
  end

  private
  def login_check
    redirect_to current_user.budget if current_user
  end
end
