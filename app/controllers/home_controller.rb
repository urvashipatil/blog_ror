class HomeController <ApplicationController

  

  def ok

    #try to render a default view
    # views/conrollername/index.html.erb

    render plain: "OK"
  end

  def index  
    @categories = Category.all  
    @tags = Tag.all  
    @posts =["post1","post2"]
  end

  def about
    
  end

  def contact
    
  end

end