class MeasureablesController < ApplicationController
  def show
    @measureable = Measureable.find(params[:id]) || @measureables.first
    @time_scale  = params[:time_scale] || 'hourly'
    @metric_count = params[:metric_count] || 50

    @measureables = Measureable.where(:service => @measureable.service)

    respond_to do |format|
      format.html
      format.json { render :json => @measureable.chart_data(@time_scale, @metric_count.to_i).to_json }
    end
  end
end
