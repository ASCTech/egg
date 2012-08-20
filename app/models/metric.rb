class Metric < ActiveRecord::Base
  belongs_to :measureable
  attr_accessible :count, :time_pointer, :measureable_id

  abstract_class = true

  default_scope order ("time_pointer DESC")

  TIME_SCALES = %w{ hourly daily weekly monthly }

  def self.increment(time_pointer, measureable_id)
    metric = find_or_create_by_time_pointer(:time_pointer => time_pointer, :measureable_id => measureable_id)
    metric.update_column(:count, metric.count + 1)
  end

end

