class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:show, :destroy, :edit, :update]

  def index
    @tags = Tag.all

    if(params[:format] == "json")
      render json: @tags
    else 

    end
    
  end

  def show
    # @tag = Tag.find(params[:id])
  end

  def edit
    # @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  # Post /tags  to create new tag
  def create
    # p params
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: "Tag was created successfully!"
    else 
      render :new
    end
   
  end

   # Post /tags  to update tag
   def update

    if @tag.update(tag_params)
      redirect_to tags_path, notice: "Tag was updated successfully!"
    else
      render :edit
    end

   end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    redirect_to tags_path, notice: "Tag was successfully deleted!"
  end

  private
  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
