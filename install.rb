# Install hook code here
require 'fileutils'

thumbwebs_config = File.dirname(__FILE__) + '/../../../config/thumbwebs.yml'
FileUtils.cp File.dirname(__FILE__) + '/thumbwebs.yml.tpl', thumbwebs_config unless File.exist?(thumbwebs_config)

### copy public files directory to main Rails app
thumbwebs_public = File.dirname(__FILE__) + '/../../../public/thumbwebs                                                                                                                                                                                                                                                                                                                              '
FileUtils.cp_r File.dirname(__FILE__) + '/public_files', thumbwebs_public unless File.exist?(thumbwebs_config)

### display readme file when installation finishes
puts IO.read(File.join(File.dirname(__FILE__), 'README'))