require 'net/http'
require 'uri'

class AuthController < ApplicationController
  def new
    redirect_to 'https://github.com/login/oauth/authorize?client_id=d622db2196e224192a02'
  end
  def callback
    @code = params[:code]
  end
  def access_token
    res = Net::HTTP.post_form(URI.parse('https://github.com/login/oauth/access_token'), {
      'client_id'=>'d622db2196e224192a02',
      'client_secret'=>'def001b106de5bb3a594beae35a4d468064e077e',
      'code'=>params[:code]
      })
    puts res.body
    url = 'https://api.github.com/user?' + res.body
    redirect_to url
  end
end
