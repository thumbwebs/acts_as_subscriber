# desc "Explaining what the task does"
# task :thumbwebs do
#   # Task goes here
# end
 PLUGIN_ROOT = File.dirname(__FILE__) + '/../'

namespace :thumbwebs do
  
  desc 'Installs required swf & javascript files to the public/javascripts directory.'
  task :install do
    FileUtils.cp_r Dir[PLUGIN_ROOT + '/public_files/images'], RAILS_ROOT + '/public/images/thumbwebs/'
    FileUtils.cp_r Dir[PLUGIN_ROOT + '/public_files/javascripts'], RAILS_ROOT + '/public/javascripts/thumbwebs/'
    #FileUtils.cp_r Dir[PLUGIN_ROOT + '/public_files/swf'], RAILS_ROOT + '/public/images/thumbwebs/'
    
    #FileUtils.cp Dir[PLUGIN_ROOT + '/assets/javascripts/*.js'], RAILS_ROOT + '/public/javascripts'
  end
  
  desc 'Removes the swf & javascripts & images for the thumbwebs plugin.'
  task :remove do
    #FileUtils.rm %{ufo.js}.collect { |f| RAILS_ROOT + "/public/thumbwebs/javascripts/" + f  }
    FileUtils.rmtree %{thumbwebs}.collect { |f| RAILS_ROOT + "/public/images/" + f } #trees to rm
    FileUtils.rmtree %{thumbwebs}.collect { |f| RAILS_ROOT + "/public/javascripts/" + f } #trees to rm
  
  end
  
  
end  
