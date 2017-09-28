class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    return unless logged_in?
    store_location
    flash[:danger] = t "controllers.application_controller.login"
    redirect_to login_url
  end
end
