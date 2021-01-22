require 'pry'
require 'twitter'
require 'dotenv'

Dotenv.load('.env')

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

# Follow the last 3 people who tweeted with the hashtag #bonjour_monde
user_names =[]
i = 0
while user_names.uniq.length < 3
  client.search("#bonjour_monde", result_type: "recent").take(3+i).each do |tweet|
    user_names.push(tweet.user.screen_name)
  end
  i = i + 1
end
client.follow(user_names.uniq)