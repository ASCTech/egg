class WeeklyMetric < ActiveRecord::Base
  belongs_to :measureable
  attr_accessible :count, :week
end
