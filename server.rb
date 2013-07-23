require 'sinatra'
require 'haml'
require 'sass'
require 'yaml'
require 'meeting_dates'
require 'config'
require 'helpers'
require 'twitter'

## VIEWS
get '/' do
  @next_meeting      = MeetingDates.new.next
  # @next_meeting = Meeting.new(Date.new(2013,7,10) + 18.hours)

  info               = YAML::load(File.open('meetings.yml'))
  next_meeting_talks = info[@next_meeting.date.strftime("%D")]

  @next_meeting.speakers = next_meeting_talks['speakers'] || [] rescue []
  @next_meeting.fotm     = next_meeting_talks['fotm']  || [] rescue []

  @mailing_list = "http://groups.google.com/group/columbusclojure"
  @twitter_url  = "https://twitter.com/columbusclojure"

  haml :welcome
end

get '/tweets', :provides => 'json' do
  Twitter.user_timeline("columbusclojure").to_json
end

not_found do
  redirect '/'
end

## STYLESHEETS
get '/:stylesheet.css' do |stylesheet|
  sass stylesheet.to_sym
end
