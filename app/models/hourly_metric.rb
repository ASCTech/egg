class HourlyMetric < Metric

  def hour_of_day
    time_pointer % 24
  end

  def label
    (Time.at(0) + time_pointer.hours).strftime("%a %-I %p")
  end

end
