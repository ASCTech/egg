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

  def self.chart_data_for(service, time_scale, metric_count)
    chart_data = []
    chart_options = { "xaxis" => { "ticks" => {} } }

    where(:service => service).each do |measureable|

      data, options = measureable.chart_data(time_scale, metric_count)

      data.each {|datum| chart_data << datum}
      chart_options["xaxis"]["ticks"] = options["xaxis"]["ticks"]
    end

    [chart_data, chart_options]
  end

  def chart_data(time_scale, metric_count)
    chart_data = []
    chart_options = { "xaxis" => { "ticks" => {} } }

    metrics = send("#{time_scale}_metrics").limit(metric_count)
    metrics.each do |metric|
      chart_options["xaxis"]["ticks"][metric.time_pointer] = metric.label if metric.time_pointer % ((metric_count / 50) * metric.modulus) == 0
    end

    chart_data << {'label' => name, 'clickable' => true, 'bars' => { 'show' => true , 'lineWidth' => 0 }, 'data' => metrics.map{|metric| [metric.time_pointer, metric.count]}}
    chart_options["xaxis"]["ticks"] = chart_options["xaxis"]["ticks"].to_a
    [chart_data, chart_options]
  end
end
