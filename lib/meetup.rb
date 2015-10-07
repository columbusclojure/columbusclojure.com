require "http"
require "json"

class Meetup
  API_KEY = ENV["MEETUP_API_KEY"]
  EVENTS_URL = "https://api.meetup.com/2/events"
  GROUP_NAME = "ColumbusClojure"

  def self.next_meeting
    resp = HTTP.accept(:json).get(EVENTS_URL, params: {
      group_urlname: GROUP_NAME,
      key: API_KEY
    })
    if resp.status_code.to_i == 200
      JSON.parse(resp.body.to_s)["results"]
    end
  end

  def initiliaze(attrs)
    @attrs = attrs
  end
end
