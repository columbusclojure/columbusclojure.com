helpers do
  def formatted_weekday(date)
    date.strftime("%A")
  end

  def formatted_month_day(date)
    date.strftime("%b %d")
  end

  def formatted_time(date)
    date.strftime("%l:%M%P")
  end
end
