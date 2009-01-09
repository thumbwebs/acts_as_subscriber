# Install hook code here
require 'fileutils'

thumbwebs_config = File.dirname(__FILE__) + '/../../../config/thumbwebs.yml'
FileUtils.cp File.dirname(__FILE__) + '/thumbwebs.yml.tpl', thumbwebs_config unless File.exist?(thumbwebs_config)
puts IO.read(File.join(File.dirname(__FILE__), 'README'))