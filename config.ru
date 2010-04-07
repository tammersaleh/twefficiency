$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")

require 'lib/twefficiency'
run Sinatra::Application

