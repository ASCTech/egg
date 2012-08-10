require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @event = Event.new :happened_at => Time.at(100000000)
  end

  test "hour" do
    assert_equal 27777, @event.hour
  end

  test "day" do
    assert_equal 1157, @event.day
  end

  test "week" do
    assert_equal 165, @event.week
  end

  test "month" do
    assert_equal 39, @event.month
  end

end
