class Articles::TagsController < ApplicationController
  def index
    tag = current_user.tags.find_by!(id: params[:id])
    @articles = tag.articles.all
  end
end
