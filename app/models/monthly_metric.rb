class MonthlyMetric < Metric

  def month_of_year
    time_pointer % 12 + 1
  end

end
