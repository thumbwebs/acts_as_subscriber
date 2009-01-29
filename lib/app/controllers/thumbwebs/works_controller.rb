class Thumbwebs::WorksController < ApplicationController
  before_filter :login_required, :except => [:index, :show] 
  before_filter :thumbwebs_setup
 ## TODO need before_filter for producer
  before_filter :owner_required, :only => [:manage, :new, :destroy]
      prepend_view_path("#{THUMBWEBS_VIEWS}works")
      prepend_view_path(THUMBWEBS_VIEWS_PARTIALS)
   do_thumbwebs_rescues
    ## adds path vendor/plugins/thumbwebs/lib/app/views/thumbwebs/channels to view_path
   
  ## if is is_logged_in set email address in activeresourceheaders


   
  def index
    @works = Thumbwebs::Work.find(:all, :include => :media_items)
 # TODO, to_xml and namespaced models  
 #see http://dev.rubyonrails.org/ticket/8305,  to_xml does not work with namespaced models
 #see http://snakesgemscoffee.blogspot.com/2007/05/activerecordbasetoxml-woes.html
 #see http://dev.rubyonrails.org/attachment/ticket/8308/xml_serialize.patch   
    respond_to do |format|
      format.html {render :template => "index"}
      format.xml  {render :xml => @works.to_xml( :root => 'thumbwebs:articles' , :children => 'thumbwebs:article') }
    end
  end

  # GET /chatters/1
  # GET /chatters/1.xml
  def show
     @work = Thumbwebs::Work.find(params[:id])
                                                   
 
    #see http://dev.rubyonrails.org/ticket/8305,  to_xml does not work with namespaced models
    #
    respond_to do |format|
      format.html{render :template => "show"} # show.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /chatters/new
  # GET /chatters/new.xml
  def new
    @work = Thumbwebs::Work.new(:title =>'', :synopsis => '',:body =>'', :published =>'',
                                      :rights =>'', :channel_id => '')

    respond_to do |format|
      format.html {render :template => "new"}# new.html.erb
      format.xml  { render :xml => @work, :root => 'thumbwebs:works' }
    end
  end

  # GET /chatters/1/edit
  def edit
    @work  = Thumbwebs::Work.find(params[:id])
    
    respond_to do |format|
      format.html {render :template => "edit"}
      format.xml  { render :xml => @work }
    end
  end

  # POST /chatters
  # POST /chatters.xml
  def create
    @work = Thumbwebs::Work.new(params[:article])
    @work.user_id = current_user.id
    @work.channel_id = params['channel_id']    
    respond_to do |format|
      if @work.save
        flash[:notice] = 'Work was successfully created.'
        format.html { redirect_to(thumbwebs_channel_works_path) }
        format.xml  { render :xml => @work, :status => :created, :location => @work }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chatters/1
  # PUT /chatters/1.xml
  def update
    work = Thumbwebs::Work.find(params[:id])
   # article.update_attributes(params[:article])
      #headers['X-THUMBWEBS_USER_EMAIL'] = 'jimmy@jimmyeaton.com'

   # @article = params[:article]
    respond_to do |format|
      if work.update_attributes(params[:work])
     #if article.save
        flash[:notice] = 'Work was successfully updated.'
        format.html { redirect_to(thumbwebs_channel_works_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chatters/1
  # DELETE /chatters/1.xml
  def destroy
    @article = Thumbwebs::Work.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(thumbwebs_channel_works_url) }
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
        format.xml { render :xml => @works.to_xml }
      end
    end
  def show_errors
     render :template => "show_errors" # show.html.erb  
    
  end  
  
  def play
    @media_item = Thumbwebs::MediaItem.find(:one, :from => :play, :params => {:media_item_id => params['media_item_id']})
    
    respond_to do |format|
      format.html { render :template => 'play'  }
      #format.mobile {   }
      #format.iphone { }
      format.xml { render :xml => @media_item.to_xml }
    end
  end  
  
  private
  
  def thumbwebs_setup
    ## need to escape ActiveResources errors
   

    ## prepends path.  will look here first.  Will not conflict with existing views.
    prepend_view_path("#{THUMBWEBS_VIEWS}/works")
    ## appends to end. allows developer to override our views.  rails will look at conventional
    ## template path first.  May conflict with existing views.
    #append_view_path("#{THUMBWEBS_VIEWS}/channels")
         ### checks to see if user is logged in and if so sets header for activeresource
      if logged_in?
        Thumbwebs::Work.headers['X-THUMBWEBS_USER_EMAIL'] = current_user.email  
      else
        Thumbwebs::Work.headers['X-THUMBWEBS_USER_EMAIL'] = '' 
      end 
  end  
end
