require 'sinatra'
require 'sinatra/json'
require 'haml'
require 'sass'
require 'config'
require 'helpers'

require 'twitter'

require 'meeting_info_finder'
require 'meeting_date_calculator'

## VIEWS
get '/' do
  @next_meeting = MeetingInfoFinder.new('./data/meetings.yml')
                    .find(MeetingDateCalculator.next)
  @mailing_list = "http://groups.google.com/group/columbusclojure"
  @twitter_url  = "https://twitter.com/columbusclojure"

  haml :welcome
end

get '/tweets', :provides => 'json' do
  headers \
    "Access-Control-Allow-Origin" => "*"

  twitter_client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
    config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
  end
  tweets = twitter_client.user_timeline("columbusclojure").map { |tweet| tweet.attrs }

  json tweets
end

get '/ping' do
  "Pinged at #{Time.now}"
end

not_found do
  redirect '/'
end

## STYLESHEETS
get '/:stylesheet.css' do |stylesheet|
  sass stylesheet.to_sym
end
