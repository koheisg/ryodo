class TagsController < ApplicationController
  before_action :verify_user

  def index
    @tags = current_user.tags.all
  end

  def new
    @tag = current_user.tags.build
  end

  def create
    tag = current_user.tags.build(tag_params)
    if tag.save
      redirect_to tags_path
    else
      @tag = tag
      respond_to do |format|
        format.html { render :new }
      end
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
      @tag = tag
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def destroy
    @tag = current_user.tags.find_by!(id: params[:id])
    @tag.destroy
    redirect_to tags_path
  end

  private

    def tag_params
      params.require(:tag).permit(:name)
    end
end
