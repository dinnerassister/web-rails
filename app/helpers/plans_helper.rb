module PlansHelper
  def weekday_name(date)
    date.strftime('%A')
  end
end
