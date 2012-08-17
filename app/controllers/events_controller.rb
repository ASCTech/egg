class EventsController < ActionController::Metal

  def create
    measureable = Measureable.find_or_create_by_name(params[:name], :service => params[:service])
    event = measureable.events.build(:timestamp => params[:timestamp])
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
