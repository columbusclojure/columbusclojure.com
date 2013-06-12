configure do
  set :haml, { :format => :html5 }
  set :sass, { :style => :compact }
end

Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
end
