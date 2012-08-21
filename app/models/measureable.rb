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

  def self.chart_data_for(service, time_scale)
    chart_data = []
    chart_options = { "xaxis" => { "ticks" => {} } }
    where(:service => service).each do |measureable|
      metrics = measureable.send("#{time_scale}_metrics").limit(50)
      metrics.each do |metric|
        chart_options["xaxis"]["ticks"][metric.time_pointer] = metric.label if metric.time_pointer % 6 == 0
      end
      chart_data << {'label' => measureable.name, 'bars' => { 'show' => true }, 'data' => metrics.map{|metric| [metric.time_pointer, metric.count]}}
    end
    chart_options["xaxis"]["ticks"] = chart_options["xaxis"]["ticks"].to_a
    [chart_data, chart_options]
  end
end
