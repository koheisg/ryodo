module ArticlesHelper
  def post_link_to(article)
    post_path(id: article.id, permalink: article.to_param)
  end
end
