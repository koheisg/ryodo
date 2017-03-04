class ArticlesController < ApplicationController
  before_action :verify_user, except: :show
  before_action :set_article, only: %i(edit update)

  def index
    @articles = current_user.articles.all
  end

  def show
    @article = Article.find_by!(id: params[:id])
  end

  def new
    @article = current_user.articles.build
    @article.article_tags.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def edit
    @article.article_tags.build
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to articles_path
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :article_tags_attributes => [:tag_id, :id])
    end

    def set_article
      @article = current_user.articles.find_by!(id: params[:id])
    end
end
