class WeeklyMetric < ActiveRecord::Base
  belongs_to :measureable
  attr_accessible :count, :week, :measureable_id

  def self.add (event)
    metric = find_or_create_by_week(:week => event.week, :measureable_id => event.measureable_id, :count => 1)
    metric.update_column(:count, metric.count + 1) unless metric.count == 1
  end

end
