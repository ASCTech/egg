class DailyMetric < Metric

  def day_of_week
    (time_pointer + 3) % 7
  end

  def label
    Time.at(0).advance(:days => time_pointer).strftime("%a %m/%d")
  end

  def modulus
    7
  end

  def self.current_time_pointer
    Time.zone.now.to_i / 1.day
  end

end
