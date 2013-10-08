require 'yaml'

class Meeting
  attr_accessor :date, :speakers, :fotm

  def initialize(date = Time.now.beginning_of_day)
    @date = date

    next_meeting_talks = self.class.info[date.strftime("%D")]

    @speakers = next_meeting_talks['speakers'] || [] rescue []
    @fotm     = next_meeting_talks['fotm']  || [] rescue []
  end

  def self.info
    YAML::load(File.open('meetings.yml'))
  end

  def self.dates
    info.keys.grep(/(\d+)\/(\d+)\/(\d+)/) do |m|
      Date.new(2000 + $3.to_i, $1.to_i, $2.to_i)
    end
  end
end
