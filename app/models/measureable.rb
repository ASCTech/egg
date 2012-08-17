class Measureable < ActiveRecord::Base
  attr_accessible :name, :service
  has_many :events

  def self.lookup_id_for(service, name)
    Rails.cache.fetch("measurable_id_for[#{service},#{name}]") do
      find_or_create_by_service_and_name(service, name).id
    end
  end

end
