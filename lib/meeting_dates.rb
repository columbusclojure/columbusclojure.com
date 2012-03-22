class MeetingDates
  def initialize
    @meeting_dates = []
    calc_meeting_dates
  end

  def calc_meeting_dates
    start_date = Date.today.beginning_of_year
    (0..12).inject([]){|s, num| dates_for_month(start_date + num.months)}
  end

  def dates_for_month(relative_date)
    s = relative_date.beginning_of_month
    e = relative_date.end_of_month
    meeting_date = first_wednesday(s..e)
    @meeting_dates << meeting_date
  end

  def next_meeting
    @meeting_dates.find{|d| d > Time.now}
  end

  def first_wednesday(range)
    range.select{|d| d.wday == 3}[0] + 18.hours
  end
end
