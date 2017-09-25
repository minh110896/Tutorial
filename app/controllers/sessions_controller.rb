class SessionsController < ApplicationController
  def new; end

  def remember_user
    user = User.find_by email: params[:session][:email].downcase
    params[:session][:remember_me] == Settings.session ? remember(user) : forget(user)
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember_user
      redirect_back_or user
    else
      flash.now[:danger] = t "controllers.sessions_controller.warn"
      render "static_pages/home"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
