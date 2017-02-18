class ArticlesController < ApplicationController
  before_action :verify_user

  def index
    @articles = current_user.articles.all
  end

  def new
    @article = current_user.articles.build
    @tag = @article.tags.build
  end

  def create
    article = current_user.articles.build(article_params)
    tag = article.tags.build(tag_params)
    if article.save && tag.save
      redirect_to articles_path
    else
      #not yet written
    end
  end

  def update
    article = current_user.articles.find_by!(id: params[:id])
    if article.update_attributes(article_params)
      redirect_to articles_path
    else
      #not yet written
    end
  end

  def edit
    @article = current_user.articles.find_by!(id: params[:id])
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def tag_params
      params.require(:tag).permit(:tag)
    end
end
