class Event < ActiveRecord::Base
  attr_accessible :timestamp, :measureable_id
  belongs_to :measureable

  validates_presence_of :timestamp

  def hour; timestamp.to_i / 1.hour; end
  def day;  timestamp.to_i / 1.day;  end
  def week; timestamp.to_i / 1.week; end

  def month
    (timestamp.year - 1970) * 12 + timestamp.month
  end

  after_create :increment_metrics


  private
  def increment_metrics
    return if processed?

    transaction do
      HourlyMetric.increment  hour,   measureable_id
      DailyMetric.increment   day,    measureable_id
      WeeklyMetric.increment  week,   measureable_id
      MonthlyMetric.increment month,  measureable_id
      update_column :processed, true
    end
  end

  handle_asynchronously :increment_metrics

end
