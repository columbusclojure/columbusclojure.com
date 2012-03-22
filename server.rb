require 'sinatra'
require 'haml'
require 'sass'
require 'yaml'
require 'active_support/all'
require './lib/meeting_dates'

helpers do
  def formatted_date(date)
    day = date.day.ordinalize
    date.strftime("%A, %B #{day}, %Y at %l:%M%P")
  end
end

configure do
  set :haml, { :format => :html5 }
  set :sass, { :style => :compact }
end

## VIEWS
get '/' do
  dates         = MeetingDates.new
  info          = YAML::load(File.open('meetings.yml'))
  @next_meeting = dates.next_meeting
  date          = @next_meeting.strftime('%D')
  @speakers     = info[date] || []
  @mailing_list = "http://groups.google.com/group/inclojure-coclug"
  
  haml :welcome
end

not_found do
  redirect '/'
end

## STYLESHEETS
get '/:stylesheet.css' do |stylesheet|
  sass stylesheet.to_sym
end
