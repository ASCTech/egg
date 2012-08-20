class Measureable < ActiveRecord::Base
  attr_accessible :name, :service
  has_many :events
  has_many :hourly_metrics
  has_many :daily_metrics
  has_many :weekly_metrics
  has_many :monthly_metrics

  def self.lookup_id_for(service, name)
    Rails.cache.fetch("measurable_id_for[#{service},#{name}]") do
      find_or_create_by_service_and_name(service, name).id
    end
  end

  def self.chart_data_for(service)
    data = []
    where(:service => service).each do |measureable|
      data << {'label' => measureable.name, 'data' => measureable.hourly_metrics.map{|metric| [metric.hour, metric.count]}}
    end
    data
  end
end
