class ArticlesController < ApplicationController
  before_action :verify_user

  def index
    @articles = current_user.articles.all
  end

  def new
    @article = current_user.articles.build
  end

  def create
    article = current_user.articles.build(article_params)
    article.article_tags.build(article_tag_params)
    if article.save
      redirect_to articles_path
    else
      #not yet written
    end
  end

  def edit
    @article = current_user.articles.find_by!(id: params[:id])
    @article.article_tags.build
  end

  def update
    article = current_user.articles.find_by!(id: params[:id])
    if article.update_attributes(article_params)
      if article.article_tags.first # すでにATがある場合は、値を見て更新
        if article_tag_params.empty?
          # ない場合の記述はまだ書かない
        else
          article.article_tags.first.update_attributes(article_tag_params)
        end
      else # ない場合は、値を見て新規保存
        if article_tag_params.empty?
          # ない場合の記述はまだ書かない
        else
          article.article_tags.create!(article_tag_params)
        end
      end

      redirect_to articles_path
    else
      #not yet written
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def article_tag_params
      params.require(:article_tag).permit(:tag_id)
    end
end
