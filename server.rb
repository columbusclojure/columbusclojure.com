$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/lib')).uniq!

require 'sinatra'
require 'haml'
require 'sass'
require 'yaml'
require 'meeting_dates'
require 'pry'

helpers do
  def formatted_weekday(date)
    date.strftime("%A")
  end

  def formatted_month_day(date)
    date.strftime("%b %d")
  end

  def formatted_time(date)
    date.strftime("%l:%M%P")
  end
end

configure do
  set :haml, { :format => :html5 }
  set :sass, { :style => :compact }
end

## VIEWS
get '/' do
  info              = YAML::load(File.open('meetings.yml'))
  @next_meeting     = MeetingDates.new.next
  next_meeting_date = @next_meeting.date.strftime('%D')
  @speakers         = info[next_meeting_date]['speakers'] || []
  @fotm             = info[next_meeting_date]['fotm'] || []

  @mailing_list = "http://groups.google.com/group/columbusclojure"

  haml :welcome
end

not_found do
  redirect '/'
end

## STYLESHEETS
get '/:stylesheet.css' do |stylesheet|
  sass stylesheet.to_sym
end
