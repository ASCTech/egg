class MeasureablesController < ApplicationController
  before_filter :require_shibboleth
  def show
    @measureable = Measureable.find(params[:id])
    @time_scale  = params[:time_scale] || 'hourly'
    @go_back_to = params[:go_back_to] || Metric[@time_scale].fifty_ago

    @service = @measureable.service

    @measureables = @service.measureables

    respond_to do |format|
      format.html
      format.json { render :json => @measureable.chart_data(@time_scale, @go_back_to.to_i).to_json }
    end
  end
end
