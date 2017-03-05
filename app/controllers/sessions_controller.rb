class SessionsController < ApplicationController
  include Authorization

  def new
    url = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=http%3A%2F%2Flocalhost%3A3000/github/authorize/callback/login&scope=user%20repo"
    redirect_to url
  end

  def create
<<<<<<< b16d741961364466c8bafa6b05fa5ed59b33b487
    access_token = request_access_token(params[:code])
    email = get_email_from_github(access_token)
    user = User.find_by(email: email)
=======
    user = User.find_by(email: user_params[:email])
>>>>>>> Change login views and sessioncontroller
    if user
      session[:user_id] = user.id
      redirect_to articles_path
    else
      redirect_to root_path # temporary
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path # temporary
  end
end
