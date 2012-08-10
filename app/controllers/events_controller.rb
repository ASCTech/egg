class EventsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    measureable = Measureable.find_or_create_by_name(params[:name], :service => params[:service])
    event = Event.find_or_create_by_measureable_id(measureable.id, :happened_at => params[:date])
    render :json => event.
  end

end
