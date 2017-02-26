class ArticleTagsController < ApplicationController
  def destroy
    articletag = ArticleTag.find_by!(id: params[:id])
    article_id = articletag.article_id
    articletag.destroy
    redirect_to edit_article_path(id: article_id)
  end
end
