require 'active_support/all'
require 'meeting'
require 'chronic'

class MeetingDates
  SIX_OCLOCK = 18.hours
  WEDNESDAY = 3

  def self.next
    now = Time.now
    if self.within_first_week(now)
      if now.wday != WEDNESDAY
        next_meeting_day = Chronic.parse('next wednesday')
      end
    else
      next_meeting_day = Chronic.parse('first wednesday next month')
    end
    Meeting.new((next_meeting_day || now).beginning_of_day + SIX_OCLOCK)
  end

  def self.within_first_week(d)
    d.day <= 7
  end
end
