class SessionsController < ApplicationController
  include Authorization
  before_action :is_login, only: %i(new)

  def new
    url = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=#{app_host}/github/authorize/callback/login&scope=user%20repo"
    redirect_to url
  end

  def create
    access_token = request_access_token(params[:code])
    email = get_email_from_github(access_token)
    user = User.find_by(email: email)
    if user
      session[:user_id] = user.id
      redirect_to articles_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

    def app_host
      URI.escape ENV['APP_HOST']
    end
end
