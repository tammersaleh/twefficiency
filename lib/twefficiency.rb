require 'sinatra'
require 'sinatra/ratpack'
require 'helpers'
require 'haml'
require 'sass'
require 'twitter'

root_dir = File.join(File.dirname(__FILE__), "..")
set :root, root_dir

# FileUtils.mkdir_p(File.join(root_dir, "log")) unless File.exists?('log')
# log = File.new(File.join(root_dir, "log", "sinatra.log"), "a")
# $stdout.reopen(log)
# $stderr.reopen(log)

helpers Sinatra::Ratpack
helpers Helpers

get "/" do
  haml :index
end

get '/for' do
  @username = params[:username]
  @tweets = Twitter::Search.new.from(@username).to_a
  @total_chars = @tweets.inject(0) {|sum, tweet| sum += tweet.text.length }
  if @tweets.empty?
    @avg_tweet_length = 0
    @twefficiency = 0
  else
    @avg_tweet_length = @total_chars / @tweets.length unless @tweets.length.zero?
    @twefficiency = @avg_tweet_length / 140.0
  end
  haml :results
end

get '/about' do
  haml :about
end

get '/stylesheets/sass/:sheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :"stylesheets/#{params[:sheet]}"
end
  
