class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    User.find_by(id: session[:user_id]) || User::Logout.new
  end

  def verify_user
    redirect_to login_path unless current_user.login?
  end
end
