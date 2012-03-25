require 'active_support/all'

class MeetingDates
  def initialize
    @meeting_dates = []
    calc_meeting_dates
  end

  def next_meeting
    @meeting_dates.find{|d| d > Time.now}
  end

  protected

  def calc_meeting_dates
    start_date = Date.today.beginning_of_year
    (0..12).each { |num|
      @meeting_dates << meeting_date_for_month(start_date + num.months)
    }
  end

  def meeting_date_for_month(relative_date)
    s = relative_date.beginning_of_month
    e = relative_date.end_of_month
    first_wednesday(s..e)
  end

  def first_wednesday(date_range)
    date_range.select{|d| d.wday == 3}[0] + 18.hours
  end
end