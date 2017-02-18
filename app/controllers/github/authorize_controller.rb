class Github::AuthorizeController < ApplicationController
  before_action :verify_user

  def new
    url = "https://github.com/login/oauth/authorize?client_id=#{ENV['CLIENT_ID']}"
    redirect_to url
  end

  def callback
    @code = params[:code]
  end

  def access_token
      res = Net::HTTP.post_form(URI.parse('https://github.com/login/oauth/access_token'), {
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET'],
        code: params[:code]
      })
      at_params = CGI.parse(res.body)
      access_token = GithubAccessToken.find_or_initialize_by(user: current_user)
      if access_token.new_record?
        current_user.github_access_token = GithubAccessToken.create(
          access_token: at_params['access_token'][0],
          scope: at_params['scope'][0],
          token_type: at_params['token_type'][0]
        )
      else
        access_token.update_attributes(
          access_token: at_params['access_token'][0],
          scope: at_params['scope'][0],
          token_type: at_params['token_type'][0]
        )
      end
      redirect_to me_edit_path
  end
end
