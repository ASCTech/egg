class Event < ActiveRecord::Base
  attr_accessible :timestamp, :measureable_id
  belongs_to :measureable

  validates_presence_of :timestamp

  %w{hour day week}.each do |time_scale|
    define_method time_scale do
      timestamp.to_i / 1.send(time_scale)
    end
  end

  def month
    (timestamp.year - 1970) * 12 + timestamp.month
  end

  after_create :create_metrics

  private
  def create_metrics
    HourlyMetric.add self
    DailyMetric.add self
    WeeklyMetric.add self
    MonthlyMetric.add self
    ActiveRecord::Base.connection.close
  end

  handle_asynchronously :create_metrics

end
