module ArticlesHelper
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
