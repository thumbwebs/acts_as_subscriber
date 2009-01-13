lass WorksController < ApplicationController
  # GET /chatters
  # GET /chatters.xml
  def index
    @works = Thumbwebs::Work.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @works }
    end
  end

  # GET /chatters/1
  # GET /chatters/1.xml
  def show
    @chatter = Chatter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chatter }
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
    @chatter = Chatter.find(params[:id])
  end

  # POST /chatters
  # POST /chatters.xml
  def create
    @chatter = Chatter.new(params[:chatter])
    @chatter.user_id = logged_in_user.id
    @chatter.service = "web"
    @chatter.channel_id = params['channel_id']    
    respond_to do |format|
      if @chatter.save
        flash[:notice] = 'Chatter was successfully created.'
        format.html { redirect_to(channel_chatter_path(:channel_id => @chatter.channel_id,
                                                        :id =>@chatter)) }
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
end
