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

puts "=> Loading Thumbwebs channel_id is: #{THUMBWEBS_CHANNEL_ID}\n"
##################################################


## setting path to view templates ################
THUMBWEBS_VIEWS = File.join(File.dirname(__FILE__), 'app', 'views/thumbwebs')
puts "THUMBWEBS_VIEWS = #{THUMBWEBS_VIEWS}"
#################################################



## Adding directories to the load path makes them appear just like files in the the
## main app directory - except that they are only loaded once, so you have to restart 
##  the web server to see the changes in the browser. Removing directories from the 
##load_once_paths allow those changes to picked up as soon as you save the 
## file - without having to restart the web server. This is particularly useful as 
## you develop the plugin.

## see http://guides.rubyonrails.org/creating_plugins.html

%w{controllers models/thumbwebs helpers/thumbwebs }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  puts "Thumbwebs: #{path}"
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end
##########################################################################

require 'thumbwebs/acts_as_thumbwebs_subscriber'



