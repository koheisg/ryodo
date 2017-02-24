class ArticlesController < ApplicationController
  before_action :verify_user, except: :show

  def index
    @articles = current_user.articles.all
  end

  def show
    @article = current_user.articles.find_by!(id: params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    article = current_user.articles.build(article_params)
    if article.save
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
end
