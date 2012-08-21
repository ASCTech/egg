class MonthlyMetric < Metric

  def month_of_year
    time_pointer % 12 + 1
  end

  def label
    Time.at(0).advance(:months => time_pointer).strftime("%m")
  end

  def modulus
    4
  end

end
