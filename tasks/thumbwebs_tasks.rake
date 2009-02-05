require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'fileutils'

PLUGIN_ROOT = File.dirname(__FILE__) + '/../'
 

namespace :thumbwebs do
  
  desc 'Default: run unit tests.'
  task :default => :test
  
  desc 'Installs required images, flash players & javascript files to the public/javascripts directory.'
  task :install do
    puts "copying thumbwebs.yml"
    thumbwebs_config =  RAILS_ROOT + '/config/thumbwebs.yml'
    FileUtils.cp File.dirname(__FILE__) + '/../thumbwebs.yml.tpl', thumbwebs_config unless File.exist?(thumbwebs_config)

    puts "copying thumbwebs images"
    ### copy public image files directory to main Rails app
    thumbwebs_public = RAILS_ROOT + '/public/images/thumbwebs/'                                                                                                                                                                                                                                                                                                                              
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
    puts "copying" 
    
  end
  
  desc 'Removes the swf & javascripts & images for the thumbwebs plugin.'
  task :remove do
    #FileUtils.rm %{ufo.js}.collect { |f| RAILS_ROOT + "/public/thumbwebs/javascripts/" + f  }
    FileUtils.rmtree %{thumbwebs}.collect { |f| RAILS_ROOT + "/public/images/" + f } #trees to rm
    FileUtils.rmtree %{thumbwebs}.collect { |f| RAILS_ROOT + "/public/javascripts/" + f } #trees to rm
  
  end
  
  desc 'Generate documentation for the Thumbwebs plugin.'
  Rake::RDocTask.new(:rdoc) do |rdoc|
    rdoc.rdoc_dir = 'rdoc'
    rdoc.title    = 'ActsAsThumbwebsSubscriber'
    rdoc.options << '--line-numbers --inline-source'
    rdoc.rdoc_files.include('README')
    rdoc.rdoc_files.include('lib/**/*.rb')
  end
  
  desc 'Test the Thumbwebs plugin.'
  Rake::TestTask.new(:test) do |t|
    t.libs << 'lib'
    t.pattern = 'test/**/*_test.rb'
    t.verbose = true
  end
end  

