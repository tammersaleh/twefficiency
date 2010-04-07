require 'sinatra/base'
require 'sinatra/ratpack'
require 'helpers'
require 'haml'
require 'sass'
require 'twitter'

class Twefficiency < Sinatra::Base
  root_dir = File.join(File.dirname(__FILE__), "..")
  env = ENV['RACK_ENV'].to_sym

  set :root,        root_dir
  set :environment, env
  set :public,      File.expand_path(root_dir + '/public')

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
  
end

