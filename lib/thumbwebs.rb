# Thumbwebs


#begin
  #@@thumbwebs_config_path =  (RAILS_ROOT + '/config/thumbwebs.yml')
 # @@thumbwebs_config = @@thumbwebs_config =YAML.load(ERB.new(File.read(@@thumbwebs_config_path)).result)[RAILS_ENV].symbolize_keys
#@@thumbwebs_config = YAML.load(ERB.new(File.read(RAILS_ROOT+"/config/thumbwebs.yml")).result)[RAILS_ENV]
#thumbwebs_config = YAML::load(File.open("#{RAILS_ROOT}/config/thumbwebs.yml"))
@@thumbwebs_config = YAML.load(ERB.new(File.read(RAILS_ROOT+"/config/thumbwebs.yml")).result)[RAILS_ENV]

#rescue
#  raise ConfigFileNotFoundError.new('File %s not found' % @@thumbwebs_config_path)
#end

#@@thumbwebs_channel_id = @@thumbwebs_config[:channel_id]
THUMBWEBS_CHANNEL_ID =  @@thumbwebs_config['channel_id']
#@@thumbwebs_api = @@thumbwebs_config[:api]
#@@thumbwebs_secret_key = @@thumbwebs_config[:secret_key]
THUMBWEBS_USERNAME = @@thumbwebs_config['username']
THUMBWEBS_PASSWORD = @@thumbwebs_config['password']
THUMBWEBS_SITE_URL = @@thumbwebs_config['site_url']

puts "=> Loading Thumbwebs channel_id is: #{THUMBWEBS_CHANNEL_ID}\n"
## Adding directories to the load path makes them appear just like files in the the
## main app directory - except that they are only loaded once, so you have to restart 
##  the web server to see the changes in the browser. Removing directories from the 
##load_once_paths allow those changes to picked up as soon as you save the 
## file - without having to restart the web server. This is particularly useful as 
## you develop the plugin.
## see http://guides.rubyonrails.org/creating_plugins.html

%w{controllers/thumbwebs models/thumbwebs views/thumbwebs helpers/thumbwebs }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  puts "Thumbwebs: #{path}"
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

require 'thumbwebs/acts_as_thumbwebs_subscriber'




#@config = YAML::load(File.open("#{RAILS_ROOT}/config/config.yml"))
