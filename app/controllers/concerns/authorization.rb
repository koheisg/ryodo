require 'json'

module Authorization
  extend ActiveSupport::Concern

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
    res = JSON.parse(res.body)
    unless res[0]
      return nil
    end
    res[0]['email']
  end

  def get_username_from_github(access_token)
    uri = URI.parse('https://api.github.com/user')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri.path)
    req["Content-Type"] = "application/json"
    req["Authorization"] = "token #{access_token}"
    res = http.request(req)
    res = JSON.parse(res.body)
    res['login']
  end
end
