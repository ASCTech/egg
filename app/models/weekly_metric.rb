class WeeklyMetric < ActiveRecord::Base
  belongs_to :measureable
  attr_accessible :count, :week

  def self.add (event)
    metric = find_or_create_by_week(:week => event.week, :measureable_id => event.measureable_id)
    metric.update_attribute :count, metric.count + 1
  end

end
