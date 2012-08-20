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

  after_create :increment_metrics

  private
  def increment_metrics
    return if processed?
    HourlyMetric.increment  hour,   measureable_id
    DailyMetric.increment   day,    measureable_id
    WeeklyMetric.increment  week,   measureable_id
    MonthlyMetric.increment month,  measureable_id
    update_column :processed, true
  end

  handle_asynchronously :increment_metrics

end
