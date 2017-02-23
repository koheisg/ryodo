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
    article.article_tags.build(tag_id: params[:article_tag][:tag_id])
    if article.save
      redirect_to articles_path
    else
      #not yet written
    end
  end

  def edit
    @article = current_user.articles.find_by!(id: params[:id])
  end

  def update
    article = current_user.articles.find_by!(id: params[:id])
    if article.update_attributes(article_params)
      if article.article_tags.first # すでにATがある場合は、値を見て更新
        if params[:article_tag][:tag_id].empty?
          # ない場合の記述はまだ書かない
        else
          article.article_tags.first.update_attributes(tag_id: params[:article_tag][:tag_id])
        end
      else # ない場合は、値を見て新規保存
        if params[:article_tag][:tag_id].empty?
          # ない場合の記述はまだ書かない
        else
          article.article_tags.create!(tag_id: params[:article_tag][:tag_id])
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
end
