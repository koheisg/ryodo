class TagsController < ApplicationController
  before_action :verify_user

  def index
    @tags = Tag.all
  end

  def new
    @tag = current_user.tags.build
  end

  def create
    tag = current_user.tags.build(tag_params)
    if tag.save
      redirect_to tags_path
    else
      # not yet written
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

    def tag_params
      params.require(:tag).permit(:name)
    end
end
