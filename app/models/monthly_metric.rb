class MonthlyMetric < ActiveRecord::Base
  belongs_to :measureable
  attr_accessible :count, :month

  def self.add (event)
    metric = find_or_create_by_month(:month => event.month, :measureable_id => event.measureable_id)
    metric.update_attribute :count, metric.count + 1
  end

end
