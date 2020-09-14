class HomeController <ApplicationController

  

  def ok

    #try to render a default view
    # views/conrollername/index.html.erb

    render plain: "OK"
  end

  def index  
    @categories = Category.all.includes(:posts)
    @tags = Tag.includes(:posts).all  
    @posts =Post.includes(:tags).published  # default_scope OR
    # @posts =Post.order_by_latest.published
  end

  def about
    
  end

  def contact
    
  end

  def read
    @post = Post.find(params[:id])
    
  end

  def search_by_tag
    if params.has_key? (:tag)
      # @posts = Tag.find_by(:name => params[:tag]).posts
      
      result = Tag.where(name: params[:tag])
      @posts = result.blank? ? [] : result.first.posts

    end
    render "home/index"
  end

end