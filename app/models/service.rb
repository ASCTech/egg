class Service < ActiveRecord::Base
  attr_accessible :name
  has_many :measureables

  before_validation :randomize_key

  validates_presence_of :key, :name
  validates_uniqueness_of :key, :name

  def randomize_key
    self.key = SecureRandom.hex(16)
  end

  def self.lookup_id_for(api_key)
    Rails.cache.fetch "service_id_for #{api_key}" do
      find_by_key(api_key).try(:id)
    end
  end
end
