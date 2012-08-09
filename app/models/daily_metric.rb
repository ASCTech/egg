class DailyMetric < ActiveRecord::Base
  belongs_to :measureable
  attr_accessible :count, :day

  def self.add (event)
    metric = find_or_create_by_day(:day => event.day, :measureable_id => event.measureable_id)
    metric.update_attribute :count, metric.count + 1
  end

end
