class Measureable < ActiveRecord::Base
  attr_accessible :name, :service
  has_many :events
end
