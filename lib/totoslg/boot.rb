require 'yaml'
require 'fileutils'
require 'totoslg'

FileUtils.mkdir_p File.expand_path("~/.totoslg")

pwd = Dir.pwd
Dir.chdir(File.dirname(__FILE__) + "/../..")
config = YAML.load_file("db/config.yml")
config['database'] = File.expand_path(config['database']) if config['database']
ActiveRecord::Base.establish_connection(config)
Dir.chdir(pwd)
