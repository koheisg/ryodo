class ArticlesController < ApplicationController
  before_action :check_login

  def index
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

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def check_login
      redirect_to login_path unless current_user.login?
    end
end
