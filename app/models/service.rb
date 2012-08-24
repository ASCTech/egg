class Service < ActiveRecord::Base
  attr_accessible :key, :name

  before_validation :randomize_key

  validates_presence_of :key, :name
  validates_uniqueness_of :key, :name

  def randomize_key
    self.key = SecureRandom.hex(16)
  end

  def lookup_id_for(api_key)
    Rails.cache.fetch "service_id_for #{api_key}" do
      Service.find_by_api_key(api_key).try(:id)
    end
  end
end
