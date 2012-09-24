class EventsController < ActionController::Metal

  def create
    unless service_id = Service.lookup_id_for(request.headers["X-API-Key"])
      self.status = 403
      self.response_body = "API Key Not Found"
      return
    end
    measureable_id = Measureable.lookup_id_for(service_id, params[:name])

    event = Event.new(:timestamp => params[:timestamp], :measureable_id => measureable_id)
    if event.save
      self.response_body = ''
      self.status = 201
    else
      self.response_body = event.errors.full_messages.join("\n")
      self.status = 400
    end
  end

  def index
    self.response_body = Event.count
  end

end
