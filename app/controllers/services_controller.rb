class ServicesController < ApplicationController

  def show
    @service    = Service.find_by_id(params[:id]) || @services.first
    @time_scale = params[:time_scale] || 'hourly'
    @go_back_to = params[:go_back_to] || Metric[@time_scale].fifty_ago

    @measureables = @service.measureables

    respond_to do |format|
      format.html
      format.json { render :json => Measureable.chart_data_for(@service, @time_scale, @go_back_to.to_i).to_json }
    end
  end

end
