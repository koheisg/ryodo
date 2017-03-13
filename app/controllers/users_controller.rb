class UsersController < ApplicationController
  include Authorization

  def new
    url = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=#{app_host}/github/authorize/callback/signup&scope=user%20repo"
    redirect_to url
  end

  def create
    access_token = request_access_token(params[:code])
    username = get_username_from_github(access_token)
    email = get_email_from_github(access_token)
    user = User.new(
      username: username,
      email: email)
    if user.save
      session[:user_id] = user.id
      redirect_to articles_path
    else
      redirect_to root_path # temporary
    end
  end

  def edit
  end

  private

    def app_host
      URI.escape ENV['APP_HOST']
    end
end
