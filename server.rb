require 'sinatra'
require 'haml'
require 'sass'
require 'meeting_dates'
require 'config'
require 'helpers'
require 'twitter'

## VIEWS
get '/' do
  @next_meeting      = MeetingDates.next
  # @next_meeting = Meeting.new(Date.new(2013,7,10) + 18.hours)

  @mailing_list = "http://groups.google.com/group/columbusclojure"
  @twitter_url  = "https://twitter.com/columbusclojure"

  haml :welcome
end

get '/tweets', :provides => 'json' do
  Twitter.user_timeline("columbusclojure").to_json
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
