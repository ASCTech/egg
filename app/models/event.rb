class Event < ActiveRecord::Base
  attr_accessible :happened_at
  belongs_to :measureable

  %w{hour day week}.each do |time_scale|
    define_method time_scale do
      happened_at.to_i / 1.send(time_scale)
    end
  end

  def month
    (happened_at.year - 1970) * 12 + happened_at.month
  end

  after_create :create_metrics

  private
  def create_metrics
    Thread.new do
      HourlyMetric.add self
      DailyMetric.add self
      WeeklyMetric.add self
      MonthlyMetric.add self
      ActiveRecord::Base.connection.close
    end
  end

end
