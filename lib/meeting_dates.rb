require 'active_support/all'
require 'meeting'

class MeetingDates
  SIX_OCLOCK = 18.hours

  def initialize
    @meeting_dates = [].to_set
    calc_meeting_dates
  end

  def next
    Meeting.new @meeting_dates.find{|d| d > Time.now.beginning_of_day}
  end

  protected

  def calc_meeting_dates
    (0..12).each_with_object(Date.today.beginning_of_year) { |num, start_date|
      @meeting_dates << meeting_date_for_month(start_date + num.months)
    }
  end

  def meeting_date_for_month(relative_date)
    s = relative_date.beginning_of_month
    e = relative_date.end_of_month
    s != Date.parse('2012-07-01') ? first_wednesday(s..e) + SIX_OCLOCK : (Date.parse('2012-07-11') + SIX_OCLOCK)
  end

  def first_wednesday(date_range)
    date_range.select{|d| d.wday == 3}[0]
  end
end
