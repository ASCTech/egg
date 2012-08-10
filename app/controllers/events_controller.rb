class EventsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    measureable = Measureable.find_or_create_by_name(params[:name], :service => params[:service])
    if event = measureable.events.create(:timestamp => params[:timestamp])
      render :nothing => true, :status => 201
    else
      render :text => event.errors.full_messages.join("\n"), :status => 400
    end
  end

  def index
    render :text => Event.count
  end

end
