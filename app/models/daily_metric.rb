class DailyMetric < Metric

  def day_of_week
    (time_pointer + 3) % 7
  end

end
