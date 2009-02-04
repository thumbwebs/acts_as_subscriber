# desc "Explaining what the task does"
# task :thumbwebs do
#   # Task goes here
# end
 PLUGIN_ROOT = File.dirname(__FILE__) + '/../'

namespace :thumbwebs do
  
  desc 'Installs required swf & javascript files to the public/javascripts directory.'
  task :install do
    puts "copying thumbwebs.yml"
    thumbwebs_config =  RAILS_ROOT + '/config/thumbwebs.yml'
    FileUtils.cp File.dirname(__FILE__) + '/../thumbwebs.yml.tpl', thumbwebs_config unless File.exist?(thumbwebs_config)

    puts "copying thumbwebs images"
    ### copy public image files directory to main Rails app
    thumbwebs_public = RAILS_ROOT + '/public/images/thumbweb/'                                                                                                                                                                                                                                                                                                                              
    FileUtils.cp_r File.dirname(__FILE__) + '/../public_files/images/', thumbwebs_public unless File.exist?(thumbwebs_config)

    puts "copying thumbwebs javascripts"
    ### copy public javascripts files directory to main Rails app
    thumbwebs_public = RAILS_ROOT + '/public/javascripts/thumbwebs/'
    thumbwebs_plugin= File.dirname(__FILE__) + '/../public_files/javascripts/'
    FileUtils.cp_r thumbwebs_plugin, thumbwebs_public unless File.exist?(thumbwebs_public)
    puts "thumbwebs_public = #{thumbwebs_public}"

    puts "copying thumbwebs flash files"
    ### copy public swf files directory to main Rails app
    thumbwebs_public = RAILS_ROOT + '/public/images/thumbwebs/' 
    FileUtils.cp_r File.dirname(__FILE__) + '/../public_files/swf/', thumbwebs_public #unless File.exist?(thumbwebs_public)
    puts "copying" end
  
  desc 'Removes the swf & javascripts & images for the thumbwebs plugin.'
  task :remove do
    #FileUtils.rm %{ufo.js}.collect { |f| RAILS_ROOT + "/public/thumbwebs/javascripts/" + f  }
    FileUtils.rmtree %{thumbwebs}.collect { |f| RAILS_ROOT + "/public/images/" + f } #trees to rm
    FileUtils.rmtree %{thumbwebs}.collect { |f| RAILS_ROOT + "/public/javascripts/" + f } #trees to rm
  
  end
  
  
end  

