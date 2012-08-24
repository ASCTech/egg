class ServicesController < ApplicationController
  def show
    @service      = Service.find(params[:id]) || @services.first
    @time_scale   = params[:time_scale] || 'hourly'
    @metric_count = params[:metric_count] || 50

    @measureables = @service.measureables

    respond_to do |format|
      format.html
      format.json { render :json => Measureable.chart_data_for(@service, @time_scale, @metric_count.to_i).to_json }
    end
  end
end
