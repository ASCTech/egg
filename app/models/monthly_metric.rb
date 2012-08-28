class MonthlyMetric < Metric

  def month_of_year
    time_pointer % 12 + 1
  end

  def label
    Time.at(0).advance(:months => time_pointer).strftime("%b '%y")
  end

  def modulus
    3
  end

  def self.current_time_pointer
    now = Time.zone.now
    (now.year - 1970) * 12 + now.month
  end

end
