class DailyMetric < ActiveRecord::Base
  belongs_to :measureable
  attr_accessible :count, :day
end
