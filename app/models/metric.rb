class Metric < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :measureable

  attr_accessible :count, :time_pointer, :measureable_id

  default_scope order ("time_pointer DESC")


  TIME_SCALES = %w{ hourly daily weekly monthly }

  def self.increment(time_pointer, measureable_id)
    attrs = {
      :time_pointer => time_pointer,
      :measureable_id => measureable_id
    }
    rows_updated = where(attrs).update_all('count = count + 1')
    case rows_updated
    when 0; create!(attrs.merge(:count => 1))
    when 1; return
    else;   raise 'Multiple Metrics updated, not good!'
    end
  end

  def self.[](time_scale)
    "#{time_scale.capitalize}Metric".constantize
  end

  def self.fifty_ago
    current_time_pointer - 50
  end

end

