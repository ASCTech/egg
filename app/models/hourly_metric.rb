class HourlyMetric < ActiveRecord::Base
  belongs_to :measureable
  attr_accessible :count, :hour, :measureable_id

  def self.add (event)
    metric = find_or_create_by_hour(:hour => event.hour, :measureable_id => event.measureable_id)
    metric.update_column(:count, metric.count + 1)
  end

end
