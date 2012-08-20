class ServicesController < ApplicationController
  def show
    @services   = Measureable.pluck(:service).uniq.sort{|a,b|a.downcase <=> b.downcase}
    @service    = params[:service] || @services.first
    @time_scale = params[:time_scale] || 'hourly'

    respond_to do |format|
      format.html
      format.json { render :json => Measureable.chart_data_for(@service, @time_scale).to_json }
    end
  end
end
