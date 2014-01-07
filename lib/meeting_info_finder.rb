require 'yaml'
require 'chronic'
require './lib/meeting'

class MeetingInfoFinder
  attr_reader :meetings

  def initialize(filename)
    yaml = YAML.load_file(filename)
    @meetings = yaml.reject{|k| k == "TBD"}.inject([]) do |meetings, (date, info)|
      meetings << Meeting.new(Chronic.parse("#{date} at 6:00PM"), info)
    end
  end

  def find(date)
    meeting_info = @meetings.bsearch {|meeting| meeting.date >= date}
    return meeting_info unless meeting_info.nil?

    meeting_info = @meetings.bsearch {|meeting| meeting.date >= Time.now}
    return meeting_info unless meeting_info.nil?

    Meeting.new date
  end
end
