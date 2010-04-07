$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")

require 'pathname'

root_dir = Pathname(__FILE__).dirname
env = ENV['RACK_ENV'].to_sym

FileUtils.mkdir_p(File.join(root_dir, "log"))  unless File.exists?('log')
log = File.new(File.join(root_dir, "log", "sinatra.log"), "a")
$stdout.reopen(log)
$stderr.reopen(log)

rvm_gemset_dir = "/Users/tsaleh/.rvm/gems/ruby-1.8.7-p249@twefficiency"
ENV["GEM_HOME"] = rvm_gemset_dir if File.directory?(rvm_gemset_dir)

require 'rubygems'
require 'sinatra'

set :app_file,    File.join(root_dir, "lib", 'twefficiency.rb')

disable :run

require 'twefficiency'

run Twefficiency

