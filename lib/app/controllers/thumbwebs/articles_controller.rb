class Thumbwebs::ArticlesController < ApplicationController
  before_filter :login_required, :except => [:index, :show] 
  before_filter :thumbwebs_setup
 ## TODO need before_filter for producer
  before_filter :owner_required, :only => [:manage]
  
  do_thumbwebs_rescues
  ## adds path vendor/plugins/thumbwebs/lib/app/views/thumbwebs/channels to view_path
  
  ## prepends path.  will look here first.  Will not conflict with existing views.
  prepend_view_path("#{THUMBWEBS_VIEWS}/articles")
  ## appends to end. allows developer to override our views.  rails will look at conventional
  ## template path first.  May conflict with existing views.
  #append_view_path("#{THUMBWEBS_VIEWS}/channels")
   
  ## if is is_logged_in set email address in activeresourceheaders


   
  def index
    @articles = Thumbwebs::Article.find(:all, :params=>{:thumbwebs_id => 1, :email => "admin@arkietv.com"})
 
 # TODO, to_xml and namespaced models  
 #see http://dev.rubyonrails.org/ticket/8305,  to_xml does not work with namespaced models
 #see http://snakesgemscoffee.blogspot.com/2007/05/activerecordbasetoxml-woes.html
 #see http://dev.rubyonrails.org/attachment/ticket/8308/xml_serialize.patch   
    respond_to do |format|
      format.html {render :template => "index"}
      format.xml  {render :xml => @articles.to_xml( :root => 'thumbwebs:articles' , :children => 'thumbwebs:article') }
    end
  end

  # GET /chatters/1
  # GET /chatters/1.xml
  def show
     @article = Thumbwebs::Article.find(params[:id], :params => {:email => "admin@arkietv.com"
                                                               })
                                                   
 
    #see http://dev.rubyonrails.org/ticket/8305,  to_xml does not work with namespaced models
    #
    respond_to do |format|
      format.html{render :template => "show"} # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /chatters/new
  # GET /chatters/new.xml
  def new
    @article = Thumbwebs::Article.new(:title =>'', :synopsis => '',:body =>'', :published =>'',
                                      :rights =>'', :channel_id => '')

    respond_to do |format|
      format.html {render :template => "new"}# new.html.erb
      format.xml  { render :xml => @article, :root => 'thumbwebs:articles' }
    end
  end

  # GET /chatters/1/edit
  def edit
    @article  = Thumbwebs::Article.find(params[:id])
    
    respond_to do |format|
      format.html {render :template => "edit"}
      format.xml  { render :xml => @article }
    end
  end

  # POST /chatters
  # POST /chatters.xml
  def create
    @article = Thumbwebs::Article.new(params[:article])
    @article.user_id = current_user.id
    @article.channel_id = params['channel_id']    
    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to(thumbwebs_channel_articles_path) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chatters/1
  # PUT /chatters/1.xml
  def update
    article = Thumbwebs::Article.find(params[:id],:params=>{:thumbwebs_id => 1, :email => "jimmy@jimmyeaton.com"})
   # article.update_attributes(params[:article])
      #headers['X-THUMBWEBS_USER_EMAIL'] = 'jimmy@jimmyeaton.com'

   # @article = params[:article]
    respond_to do |format|
      if article.update_attributes(params[:article])
     #if article.save
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(thumbwebs_channel_articles_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chatters/1
  # DELETE /chatters/1.xml
  def destroy
    @article = Thumbwebs::Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(thumbwebs_channel_articles_url) }
      format.xml  { head :ok }
    end
  end
  
  # Admin article                                                                        #
  ########################################################################################

    def manage
      
      ## will call the manage method ie, http://thumbwebs.com/channels/1/articles/manage
      @articles = Thumbwebs::Article.find(:all, :from => :manage)
      #redirect_to admin_articles_url

      respond_to do |format|
        format.html { render :template => 'index'  }
        #format.mobile {   }
        #format.iphone { }
        format.xml { render :xml => @articles.to_xml }
      end
    end
  def show_errors
     render :template => "show_errors" # show.html.erb  
    
  end  
end
