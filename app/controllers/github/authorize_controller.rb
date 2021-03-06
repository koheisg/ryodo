class Github::AuthorizeController < ApplicationController
  before_action :verify_user

  def new
    url = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&scope=user%20repo"
    redirect_to url
  end

  def create
    access_token = GithubAccessToken.find_or_initialize_by(user: current_user)
    access_token.assign_attributes(request_access_token(params[:code]))
    if access_token.save
      flash[:notice] = "連携に成功しました"
      redirect_to me_edit_path
    else
      flash[:notice] = "連携に失敗しました"
      redirect_to me_edit_path
    end
  end

  private

    def request_access_token(code)
      res = Net::HTTP.post_form(URI.parse('https://github.com/login/oauth/access_token'), {
        client_id: ENV['GITHUB_CLIENT_ID'],
        client_secret: ENV['GITHUB_CLIENT_SECRET'],
        code: code
      })
      at_params = CGI.parse(res.body)
      { access_token: at_params['access_token'][0],
        scope: at_params['scope'][0],
        token_type: at_params['token_type'][0] }
    end
end
