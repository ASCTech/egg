class ServicesController < ApplicationController
  def show
    @service     = params[:service] || @services.first
    @time_scale  = params[:time_scale] || 'hourly'

    @measureables = Measureable.where(:service => @service)
    @measureable = Measureable.where(:service => @service).first

    respond_to do |format|
      format.html
      format.json { render :json => Measureable.chart_data_for(@service, @time_scale).to_json }
    end
  end
end
