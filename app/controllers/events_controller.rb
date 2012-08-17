class EventsController < ActionController::Metal
  include ActionController::Rendering

  #skip_before_filter :verify_authenticity_token

  def create
    measureable = Measureable.find_or_create_by_name(params[:name], :service => params[:service])
    event = measureable.events.build(:timestamp => params[:timestamp])
    if event.save
      #render :nothing => true, :status => 201
      self.response_body = ""
      self.status = 201
    else
      self.response_body = event.errors.full_messages.join("\n")
      self.status = 400
    end
  end

  def index
    render :text => Event.count
  end

end
