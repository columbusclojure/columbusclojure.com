require 'chronic'

class MeetingDateCalculator
  WEDNESDAY = 3
  SIX_OCLOCK = 18

  def self.next
    next_meeting_date = next_first_wednesday
    Time.new next_meeting_date.year, next_meeting_date.month, next_meeting_date.day, SIX_OCLOCK
  end

  private

  def self.next_first_wednesday
    today = Chronic.parse('today')
    next_wednesday = Chronic.parse('next wednesday')
    if within_first_week? today and wednesday? today
      today
    elsif within_first_week? next_wednesday
      next_wednesday
    else
      Chronic.parse('first wednesday next month')
    end
  end

  def self.within_first_week?(date)
    date.day <= 7
  end

  def self.wednesday?(date)
    WEDNESDAY == date.wday
  end
end
