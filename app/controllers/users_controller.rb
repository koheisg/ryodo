require 'json'

class UsersController < ApplicationController
  def new
    url = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=http%3A%2F%2Flocalhost%3A3000/github/authorize/callback/signup&scope=user%20repo"
    redirect_to url
  end

  def create
    access_token = request_access_token(params[:code])
    res = get_email_from_github(access_token)
    res = JSON.parse(res.body)
    user = User.new(
      email: res[0]['email'])
    if user.save
      session[:user_id] = user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  private

   def request_access_token(code)
     res = Net::HTTP.post_form(URI.parse('https://github.com/login/oauth/access_token'), {
       client_id: ENV['GITHUB_CLIENT_ID'],
       client_secret: ENV['GITHUB_CLIENT_SECRET'],
       code: code
     })
     at_params = CGI.parse(res.body)
     at_params['access_token'][0]
   end

   def get_email_from_github(access_token)
     uri = URI.parse('https://api.github.com/user/emails')
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = true
     req = Net::HTTP::Get.new(uri.path)
     req["Content-Type"] = "application/json"
     req["Authorization"] = "token #{access_token}"
     res = http.request(req)
   end
end
