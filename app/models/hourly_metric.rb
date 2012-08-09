class HourlyMetric < ActiveRecord::Base
  belongs_to :measureable
  attr_accessible :count, :hour
end
