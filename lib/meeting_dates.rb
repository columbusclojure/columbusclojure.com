require 'active_support/all'
require 'meeting'
require 'chronic'

class MeetingDates
  SIX_OCLOCK = 18.hours

  def self.next
    Meeting.new(Chronic.parse('first wednesday next month').beginning_of_day + SIX_OCLOCK)
  end
end
