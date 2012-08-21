class DailyMetric < Metric

  def day_of_week
    (time_pointer + 3) % 7
  end

  def label
    (Time.at(0) + time_pointer.days).strftime("%a %d")
  end

end
