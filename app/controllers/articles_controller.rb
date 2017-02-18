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
      update_tag
      redirect_to articles_path
    else
      #not yet written
    end
  end

  def update_tag
    article = current_user.articles.find_by!(id: params[:id])
    flg = 0;
    if article.tags.empty? then
      tag = article.tags.build(tag_params)
      flg = 1;
    else
      tag = article.tags.find_by!(article: article)
    end
    if flg then
      tag.update_attributes(tag_params)
    else
      tag.save
    end
  end

  def edit
    @article = current_user.articles.find_by!(id: params[:id])
    if @article.tags.empty? then
      @tag = @article.tags.build
    else
      @tag = @article.tags.find_by!(article: @article)
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def tag_params
      params.require(:tag).permit(:tag)
    end
end
