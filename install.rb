# Install hook code here
require 'fileutils'

#TODO directory copies also copies .svn files which will cause headaches for client program
# need to remove .svn files?

puts "copying thumbwebs.yml"
thumbwebs_config = File.dirname(__FILE__) + '/../../../config/thumbwebs.yml'
FileUtils.cp File.dirname(__FILE__) + '/thumbwebs.yml.tpl', thumbwebs_config unless File.exist?(thumbwebs_config)

puts "copying thumbwebs images"
### copy public image files directory to main Rails app
thumbwebs_public = File.dirname(__FILE__) + '/../../../public/images/thumbweb/s                                                                                                                                                                                                                                                                                                                              '
FileUtils.cp_r File.dirname(__FILE__) + '/public_files/images/', thumbwebs_public unless File.exist?(thumbwebs_config)

puts "copying thumbwebs javascripts"
### copy public javascripts files directory to main Rails app
thumbwebs_public = File.dirname(__FILE__) + '/../../../public/javascripts/thumbwebs/'
thumbwebs_plugin= File.dirname(__FILE__) + '/public_files/javascripts/'
FileUtils.cp_r thumbwebs_plugin, thumbwebs_public unless File.exist?(thumbwebs_public)
puts "thumbwebs_public = #{thumbwebs_public}"

puts "copying thumbwebs flash files"
### copy public swf files directory to main Rails app
thumbwebs_public = File.dirname(__FILE__) + '/../../../public/images/thumbwebs/' 
FileUtils.cp_r File.dirname(__FILE__) + '/public_files/swf/', thumbwebs_public #unless File.exist?(thumbwebs_public)
puts "copying"

### display readme file when installation finishes
puts IO.read(File.join(File.dirname(__FILE__), 'README'))