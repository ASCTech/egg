class Event < ActiveRecord::Base
  attr_accessible :happened_at
  belongs_to :measureable

  %w{hour day week}.each do |time_scale|
    define_method time_scale do
      happened_at.to_i / 1.send(time_scale)
    end
  end

end
