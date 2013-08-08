require 'active_support/all'
require 'meeting'
require 'chronic'

class MeetingDates
  SIX_OCLOCK = 18.hours
  WEDNESDAY = 3

  def self.next
    now = Time.now
    if now.day <= 7
      if now.wday == WEDNESDAY
        Meeting.new(now.beginning_of_day + SIX_OCLOCK)
      else
        Meeting.new(Chronic.parse('next wednesday').beginning_of_day + SIX_OCLOCK)
      end
    else
      Meeting.new(Chronic.parse('first wednesday next month').beginning_of_day + SIX_OCLOCK)
    end
  end
end
