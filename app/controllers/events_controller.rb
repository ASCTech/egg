class EventsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    measureable = Measureable.find_or_create_by_name(params[:name], :service => params[:service])
    measureable.events.create!(:happened_at => params[:date])
    render :nothing => true, :status => 201
  end

  def index
    render :text => Event.count
  end

end
