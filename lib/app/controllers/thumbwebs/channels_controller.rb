class Thumbwebs::ChannelsController < ApplicationController

  ## adds path vendor/plugins/thumbwebs/lib/app/views/thumbwebs/channels to view_path
  
  ## prepends path.  will look here first.  Will not conflict with existing views.
  prepend_view_path("#{THUMBWEBS_VIEWS}/channels")
   
   ### rescues all the active_resource errors 
   do_thumbwebs_rescues   # located in plugin/lib/thumbwebs.rb
   
  

   ## appends to end. allows developer to override our views.  rails will look at conventional
   ## template path first.  May conflict with existing views.
   #append_view_path("#{THUMBWEBS_VIEWS}/channels")
   
  # GET /channels
  # GET /channels.xml
   
  def index
    @channels = Thumbwebs::Channel.find(:all, :params=>{:thumbwebs_id => 1})

    respond_to do |format|
      format.html {render :template => "index"}
      format.xml  { render :xml => @channels }
    end
  end

  # GET /chatters/1
  # GET /chatters/1.xml
  def show
     @channel = Thumbwebs::Channel.find(params[:id])
    #@channel.name ="My channel"
    #@channel.save
    respond_to do |format|
      format.html{render :template => "show"} # show.html.erb
      format.xml  { render :xml => @channel }
    end
  end

  # GET /chatters/new
  # GET /chatters/new.xml
  def new
    @chatter = Chatter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chatter }
    end
  end

  # GET /chatters/1/edit
  def edit
    @chatter = Thumbwebs::Channel.find(params[:id])
  end

  # POST /chatters
  # POST /chatters.xml
  def create
    @chatter = Thumbwebs::Channel.new(params[:chatter])
    @chatter.user_id = logged_in_user.id
    @chatter.service = "web"
    @chatter.channel_id = params['channel_id']    
    respond_to do |format|
      if @channel.save
        flash[:notice] = 'Channel was successfully created.'
        format.html { redirect_to(channel_path(:id =>@channel.id)) }
        format.xml  { render :xml => @chatter, :status => :created, :location => @chatter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chatter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chatters/1
  # PUT /chatters/1.xml
  def update
    @chatter = Chatter.find(params[:id])

    respond_to do |format|
      if @chatter.update_attributes(params[:chatter])
        flash[:notice] = 'Chatter was successfully updated.'
        format.html { redirect_to(@chatter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chatter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chatters/1
  # DELETE /chatters/1.xml
  def destroy
    @chatter = Chatter.find(params[:id])
    @chatter.destroy

    respond_to do |format|
      format.html { redirect_to(channel_chatters_url) }
      format.xml  { head :ok }
    end
  end
  
  def show_errors
     render :template => "show_errors" # show.html.erb  
    
  end  
end
