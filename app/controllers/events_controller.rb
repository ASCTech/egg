class EventsController < ActionController::Metal

  include Apian::ControllerExtensions

  def create
    return forbidden unless service_id = Service.lookup_id_for(api_key)
    measureable_id = Measureable.lookup_id_for(service_id, params[:name])

    event = Event.new(:timestamp => params[:timestamp], :measureable_id => measureable_id)
    if event.save
      self.response_body = ''
      self.status = 201
    else
      self.response_body = event.errors.full_messages.join("\n")
      Rails.logger.warn "Event not saved" + event.errors.full_messages.join("\n")
      self.status = 400
    end
  end

  def index
    self.response_body = Event.count
  end

end
