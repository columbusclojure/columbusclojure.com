require 'active_support/all'
require 'meeting'

class MeetingDates
  SIX_OCLOCK = 18.hours

  def initialize
    @meeting_dates = calc_meeting_dates
  end

  def next
    Meeting.new(next_meeting_after_today)
  end

  protected

  def next_meeting_after_today
    @meeting_dates.find{|d| d > Time.now.beginning_of_day}
  end

  def calc_meeting_dates
    start_date = Date.today.beginning_of_year
    (0..12).inject([]) do |meeting_dates, num|
      meeting_dates << meeting_date_for_month(start_date + num.months)
    end
  end

  def meeting_date_for_month(relative_date)
    s = relative_date.beginning_of_month
    e = relative_date.end_of_month
    first_wednesday(s..e) + SIX_OCLOCK
  end

  def first_wednesday(date_range)
    date_range.select{|d| d.wday == 3}[0]
  end
end
