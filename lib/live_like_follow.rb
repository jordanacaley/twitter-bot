require 'pry'
require 'twitter'
require 'dotenv'

Dotenv.load('.env')

# Streaming: Live like and follow when someone tweets with the #bonjour_monde hashtag

def static_twitter
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
    return client
  end
  
  def live_twitter
  client = Twitter::Streaming::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end
  return client
  end 
  
  live_twitter.filter(track: "#bonjour_monde") do |object|
    static_twitter.fav object
    static_twitter.follow object.user
  end