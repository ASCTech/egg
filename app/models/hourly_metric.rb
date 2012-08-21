class HourlyMetric < Metric

  def hour_of_day
    time_pointer % 24
  end

  def label
    Time.at(0).advance(:hours => time_pointer).strftime("%a %-I %p")
  end

  def modulus
    6
  end

end
