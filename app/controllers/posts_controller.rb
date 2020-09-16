class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action  :check_authorization?, only: [ :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.all.includes(:category)  
    # .order('created_at DESC')

    # # pagination kaminari
    # @posts = Post.all
    #              .includes(:category)  
    #              .order('created_at DESC')
    #              .page(params[:page]).per(5)

    # search ransack
    @q = Post.ransack(params[:q])
    @posts = @q.result()
                 .includes(:category)  
                 .order('created_at DESC')
                 .page(params[:page]).per(5)
                 
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      p "************************************************"
      p post_params
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :published, :category_id, :all_tags)

      # , tag_ids:[]

      #
    end

    def check_authorization?
      unless authorize?(@post)
        flash["notice"] = "Unauthorized"
        redirect_back(fallback_location: root_path)
      end
    end

    def authorize? (post)
      current_user.id == post.user.id
    end

    helper_method :authorize?
end
