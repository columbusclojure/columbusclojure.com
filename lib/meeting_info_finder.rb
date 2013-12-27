require 'yaml'
require 'meeting'

class MeetingInfoFinder
  attr_reader :meetings

  def initialize(filename)
    yaml = YAML.load_file(filename)
    @meetings = yaml.reject{|k| k == "TBD"}.inject([]) do |meetings, (date, info)|
      meetings << Meeting.new(date, info)
    end
  end

  def find(date)
    @meetings.bsearch {|meeting| meeting.date >= date}
  end
end
