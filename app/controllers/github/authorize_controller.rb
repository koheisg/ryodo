require 'net/http'
require 'uri'

class Github::AuthorizeController < ApplicationController
  before_action :check_login

  def new
    url = 'https://github.com/login/oauth/authorize?client_id=' + ENV['CLIENT_ID']
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
      res.body.slice!(0..12)
      access_token = res.body #文字列として切り離しているので、このままDBに保存できる

      # アクセストークンを送り返すロジック
      # url = 'https://api.github.com/user?access_token=' + access_token
      # redirect_to url #コントローラーからリダイレクトさせると認証に失敗する

      # 今回はusers#editにリダイレクトさせて、連携完了を知らせる
      redirect_to edit_user_path(:id => session[:user_id])
  end

  private

    def check_login
      redirect_to login_path unless current_user.login?
    end
end
