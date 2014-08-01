class PagesController < ApplicationController
  def front
    redirect_to home_path if current_user
  end

  def billing
    @user = current_user
  end

  def cancel_service
    @user = current_user
    @user.deactivate!
    redirect_to register_path
    flash[:notice] = "Your account has been deactivated."
  end
end