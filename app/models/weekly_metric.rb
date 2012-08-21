class WeeklyMetric < Metric

  def label
    Time.at(0).advance(:weeks => time_pointer).strftime("%a %m/%d")
  end

  def modulus
    4
  end

end
