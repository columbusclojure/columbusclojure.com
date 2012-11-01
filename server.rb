$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/lib')).uniq!

require 'sinatra'
require 'pry'
require 'haml'
require 'sass'
require 'yaml'
require 'meeting_dates'
require 'config'
require 'helpers'

## VIEWS
get '/' do
  @next_meeting      = MeetingDates.new.next

  info               = YAML::load(File.open('meetings.yml'))
  next_meeting_talks = info[@next_meeting.date.strftime("%D")]

  if next_meeting_talks
    @next_meeting.speakers = next_meeting_talks['speakers'] || []
    @next_meeting.fotm     = next_meeting_talks['fotm'] || []
  end

  @mailing_list = "http://groups.google.com/group/columbusclojure"
  @twitter_url  = "https://twitter.com/columbusclojure"

  haml :welcome
end

not_found do
  redirect '/'
end

## STYLESHEETS
get '/:stylesheet.css' do |stylesheet|
  sass stylesheet.to_sym
end
