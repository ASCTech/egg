class HourlyMetric < Metric

  def hour_of_day
    time_pointer % 24
  end

end
