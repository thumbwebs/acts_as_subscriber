# Install hook code here
require 'fileutils'

puts "copying thumbwebs.yml"
thumbwebs_config = File.dirname(__FILE__) + '/../../../config/thumbwebs.yml'
FileUtils.cp File.dirname(__FILE__) + '/thumbwebs.yml.tpl', thumbwebs_config unless File.exist?(thumbwebs_config)

puts "copying thumbwebs images"
### copy public image files directory to main Rails app
thumbwebs_public = File.dirname(__FILE__) + '/../../../public/images/thumbwebs                                                                                                                                                                                                                                                                                                                              '
FileUtils.cp_r File.dirname(__FILE__) + '/public_files/images', thumbwebs_public unless File.exist?(thumbwebs_config)

puts "copying thumbwebs javascripts"
### copy public javascripts files directory to main Rails app
thumbwebs_public = File.dirname(__FILE__) + '/../../../public/javascripts/thumbwebs                                                                                                                                                                                                                                                                                                                              '
FileUtils.cp_r File.dirname(__FILE__) + '/public_files/javascripts', thumbwebs_public unless File.exist?(thumbwebs_config)

puts "copying thumbwebs flash files"
### copy public swf files directory to main Rails app
thumbwebs_public = File.dirname(__FILE__) + '/../../../public/swf/thumbwebs                                                                                                                                                                                                                                                                                                                              '
FileUtils.cp_r File.dirname(__FILE__) + '/public_files/swf', thumbwebs_public unless File.exist?(thumbwebs_config)


### display readme file when installation finishes
puts IO.read(File.join(File.dirname(__FILE__), 'README'))