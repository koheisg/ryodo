class ArticlesController < ApplicationController
  before_action :verify_user

  def index
    @articles = current_user.articles.all
  end

  def new
    @article = current_user.articles.build
    @tag = @article.tags.build
    @user_id = current_user.id
  end

  def create
    article = current_user.articles.build(article_params)
    tag = article.tags.build(tag_params)
    tag.user_id = current_user.id
    if article.save
      redirect_to articles_path(current_user)
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

  def edit
    @article = current_user.articles.find_by!(id: params[:id])
    if @article.tags.empty?
      @tag = @article.tags.build(user_id: current_user)
    else
      @tag = @article.tags.first
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def tag_params
      params.require(:tag).permit(:name)
    end

    def update_tag
      article = current_user.articles.find_by!(id: params[:id])
      if article.tags.empty?
        tag = article.tags.build(tag_params)
        tag.user_id = current_user.id
        tag.save
      else
        tag = article.tags.find_by!(article: article)
        tag.update_attributes(tag_params)
      end
    end
end
