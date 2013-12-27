require 'sinatra'
require 'sinatra/namespace'
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

namespace '/api' do
  get '/tweets', :provides => 'json' do
    headers \
      "Access-Control-Allow-Origin" => "*"
    twitter_client.user_timeline("columbusclojure").to_json
  end
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
