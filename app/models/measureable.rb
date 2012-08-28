class Measureable < ActiveRecord::Base
  attr_accessible :name, :service_id
  has_many :events
  has_many :hourly_metrics
  has_many :daily_metrics
  has_many :weekly_metrics
  has_many :monthly_metrics
  belongs_to :service

  def self.lookup_id_for(service_id, name)
    Rails.cache.fetch("measurable_id_for[#{service_id},#{name}]") do
      find_or_create_by_service_id_and_name(service_id, name).id
    end
  end

  def self.chart_data_for(service, time_scale, go_back_to)
    chart_data = []
    chart_options = { "xaxis" => { "ticks" => {} } }

    service.measureables.each do |measureable|

      data, options = measureable.chart_data(time_scale, go_back_to)

      data.each {|datum| chart_data << datum}
      chart_options["xaxis"]["ticks"].merge! Hash[*options["xaxis"]["ticks"].flatten]
    end

    chart_options["xaxis"]["ticks"] = chart_options["xaxis"]["ticks"].to_a

    [chart_data, chart_options]
  end

  def chart_data(time_scale, go_back_to)
    chart_data = []
    chart_options = { "xaxis" => { "ticks" => {} } }
    now = Metric[time_scale].current_time_pointer

    metrics = send("#{time_scale}_metrics").where("time_pointer >= ?", go_back_to)

    metrics << Metric[time_scale].new(:time_pointer => now, :count => 0) unless metrics.last.try(:time_pointer) == now

    metrics.each do |metric|
      chart_options["xaxis"]["ticks"][metric.time_pointer] = metric.label if metric.time_pointer % (metric.modulus * (now - go_back_to) / 50) == 0
    end

    chart_data << {'label' => name, 'clickable' => true, 'bars' => { 'show' => true , 'lineWidth' => 0 }, 'data' => metrics.map{|metric| [metric.time_pointer, metric.count]}}
    chart_options["xaxis"]["ticks"] = chart_options["xaxis"]["ticks"].to_a
    [chart_data, chart_options]
  end
end
