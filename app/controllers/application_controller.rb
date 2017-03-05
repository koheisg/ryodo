class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :markdown

  def current_user
    User.find_by(id: session[:user_id]) || User::Logout.new
  end

  def verify_user
    redirect_to login_path unless current_user.login?
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      hard_wrap: true,
      filter_html: true,
      fenced_code: true,
      gh_blockcode: true,
      autolink: true,
      tables: true)
    markdown.render(text).html_safe
  end
end
