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
    @tag = current_user.tags.find_by!(id: params[:id])
  end

  def update
    tag = current_user.tags.find_by!(id: params[:id])
    if tag.update_attributes(tag_params)
      redirect_to tags_path
    else
      # not yet written
    end
  end

  def delete
  end

  private

    def tag_params
      params.require(:tag).permit(:name)
    end
end
