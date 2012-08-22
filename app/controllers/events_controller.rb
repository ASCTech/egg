class EventsController < ActionController::Metal

  def create
    logger.warn "George's request " + params[:timestamp] + " " params[:name] + " " params[:service]
    measureable_id = Measureable.lookup_id_for(params[:service], params[:name])
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
