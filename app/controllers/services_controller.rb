class ServicesController < ApplicationController
  def show
    @services = Measureable.pluck(:service).uniq.sort{|a,b|a.downcase <=> b.downcase}
  end
end
