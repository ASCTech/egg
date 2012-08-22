class ServicesController < ApplicationController
  def show
    @service      = params[:service] || @services.first
    @time_scale   = params[:time_scale] || 'hourly'
    @metric_count = params[:metric_count] || 50

    @measureables = Measureable.where(:service => @service)

    respond_to do |format|
      format.html
      format.json { render :json => Measureable.chart_data_for(@service, @time_scale, @metric_count.to_i).to_json }
    end
  end
end
