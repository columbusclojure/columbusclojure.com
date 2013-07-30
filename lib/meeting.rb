require 'yaml'

class Meeting
  attr_accessor :date, :speakers, :fotm

  def initialize(date = Time.now.beginning_of_day)
    @date = date

    info = YAML::load(File.open('meetings.yml'))
    next_meeting_talks = info[date.strftime("%D")]

    @speakers = next_meeting_talks['speakers'] || [] rescue []
    @fotm     = next_meeting_talks['fotm']  || [] rescue []
  end
end
