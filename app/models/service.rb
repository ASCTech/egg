class Service < ActiveRecord::Base
  attr_accessible :name

  has_many :measureables

  include Apian::ModelExtensions

end
