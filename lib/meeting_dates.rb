require 'active_support/all'
require 'meeting'
require 'chronic'

class MeetingDates
  SIX_OCLOCK = 18.hours

  def self.next
    if Time.now.day <= 7
      Meeting.new(Chronic.parse('first wednesday this month').beginning_of_day + SIX_OCLOCK)
    else
      Meeting.new(Chronic.parse('first wednesday next month').beginning_of_day + SIX_OCLOCK)
    end
  end
end
