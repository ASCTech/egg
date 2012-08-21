class MeasureablesController < ApplicationController
  def show
    @measureable = Measureable.find(params[:id]) || @measureables.first
    @time_scale  = params[:time_scale] || 'hourly'

    @measureables = Measureable.where(:service => @measureable.service)

    respond_to do |format|
      format.html
      format.json { render :json => @measureable.chart_data(@time_scale).to_json }
    end
  end
end
