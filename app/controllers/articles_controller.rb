class ArticlesController < ApplicationController
  before_action :check_login

  def index
  end

  def new
    @user = User.find_by(id: session[:user_id])
    @article = @user.articles.build
  end

  def create
    @user = User.find_by(id: session[:user_id])
    @article = @user.articles.build(article_params)
    @article.save
    redirect_to articles_path
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def check_login
      redirect_to login_path unless current_user.login?
    end
end
