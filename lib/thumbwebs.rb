# Thumbwebs


begin
  @@thumbwebs_config = YAML.load(ERB.new(File.read(RAILS_ROOT+"/config/thumbwebs.yml")).result)[RAILS_ENV]

rescue
raise ConfigFileNotFoundError.new('File %s not found' % @@thumbwebs_config)
end

##### set thumbwebs global variables ##############
THUMBWEBS_CHANNEL_ID =  @@thumbwebs_config['channel_id']
THUMBWEBS_USERNAME = @@thumbwebs_config['username']
THUMBWEBS_PASSWORD = @@thumbwebs_config['password']
THUMBWEBS_SITE_URL = @@thumbwebs_config['site_url']
THUMBWEBS_API = @@thumbwebs_config['api']
THUMBWEBS_AUTHORIZED_USER = @@thumbwebs_config['authorized_user']
THUMBWEBS_ARTICLES_ENABLED = @@thumbwebs_config['articles_enabled']
puts "=> Loading Thumbwebs channel_id is: #{THUMBWEBS_CHANNEL_ID}\n"
##################################################


## setting path to view templates ################
THUMBWEBS_VIEWS = File.join(File.dirname(__FILE__), 'app', 'views/thumbwebs/')
puts "THUMBWEBS_VIEWS = #{THUMBWEBS_VIEWS}"
#################################################



## Adding directories to the load path makes them appear just like files in the the
## main app directory - except that they are only loaded once, so you have to restart 
##  the web server to see the changes in the browser. Removing directories from the 
##load_once_paths allow those changes to picked up as soon as you save the 
## file - without having to restart the web server. This is particularly useful as 
## you develop the plugin.

## see http://guides.rubyonrails.org/creating_plugins.html

%w{controllers models helpers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  puts "Thumbwebs: #{path}"
  ActiveSupport::Dependencies.load_paths << path
 # ActiveSupport::Dependencies.load_once_paths.delete(path)
end
##########################################################################

require 'thumbwebs/acts_as_thumbwebs_subscriber'

### put rescue_from methods here
def thumbwebs_record_not_found
  flash[:error] = "Record not found"
  redirect_to show_errors_thumbwebs_channels_path
end

def thumbwebs_unauthorized_access
  flash[:error] = "Unauthorized Access"
  redirect_to show_errors_thumbwebs_channels_path
end  

def thumbwebs_time_out_error
  flash[:error] = "Timed Out Error"
  ### TODO stop infinite loop if server is down
  redirect_to show_errors_thumbwebs_channels_path
end  


def do_thumbwebs_rescues
  rescue_from ActiveResource::ResourceNotFound, :with => :thumbwebs_record_not_found #if RAILS_ENV == 'production'
  rescue_from ActiveResource::UnauthorizedAccess, :with => :thumbwebs_unauthorized_access
  rescue_from ActiveResource::TimeoutError, :with => :thumbwebs_time_out_error
end

def user_is_producer_of_channel?(channel_id)
  current_user.login == THUMBWEBS_AUTHORIZED_USER
end

def owner_required
   if current_user.login == THUMBWEBS_AUTHORIZED_USER
     return true
    else
      flash[:error] = "Unauthorized Access-Must be logged-in as owner."
      redirect_to show_errors_thumbwebs_channels_path
    end
end  
def thumbwebs_setup
 
       ### checks to see if user is logged in and if so sets header for activeresource
    if logged_in?
      Thumbwebs::Article.headers['X-THUMBWEBS_USER_EMAIL'] = current_user.email  
    end
end 
 class ActiveResource::Base
   def update_attributes(attributes)    
     load(attributes) && save
   end
   # This method is added for compatibility with ActiveRecord. 
   def new_record? 
    new? 
   end
 
 end 
 # Alias for +new?+ 
 
