class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_services

  def load_services
    @services = Measureable.pluck(:service).uniq.sort{|a,b|a.downcase <=> b.downcase}
  end

end
