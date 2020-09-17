class HomeController <ApplicationController

  

  def ok

    #try to render a default view
    # views/conrollername/index.html.erb

    render plain: "OK"
  end

  def index 
     
    @categories = Category.all.includes(:posts)
    @tags = Tag.includes(:posts).all  
    @posts =Post
            .includes(:tags)
            .published   # default_scope OR
            .page(params[:page])
            .per(5)
             
    
    # @posts =Post.order_by_latest.published
  end

  def about
    
  end

  def contact
    
  end

  def read
    @post = Post.includes(:comments,:user).find(params[:id])
    
  end

  def search_by_tag
    if params.has_key? (:tag)
      # @posts = Tag.find_by(:name => params[:tag]).posts
      
      result = Tag.where(name: params[:tag])
      @posts = result.blank? ? [] : result.first.posts

    end
    render "home/index"
  end

  # POST - /home/comments/:post_id
  # to save comment for a post
  def comments
   
    post = Post.find(params[:post_id])   
    comment = Comment.new(comment_params)
    comment.post = post
    comment.user = current_user   
    comment.save

    redirect_to post_read_path(post)
  end

  def search   
    if params.has_key? (:search)
      # @posts = Post.where(title: params[:search])          
      #               .includes(:tags)
      #               .published   # default_scope OR
      #               .page(params[:page])
      #               .per(5)

      @posts =Post.joins(:tags)                  
                  .where("lower(title) like ? or lower(tags.name) like ? ", "%#{params[:search]}%", "%#{params[:search]}%" )
                  .page(params[:page])
                  .per(5)
                  
    end

    render "home/index"
  end


  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end


end