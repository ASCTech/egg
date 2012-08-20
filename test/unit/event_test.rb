require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @event = Event.new :timestamp => Time.at(100000000)
  end

  context "time pointer math" do
    should "hour" do
      assert_equal 27777, @event.hour
    end

    should "day" do
      assert_equal 1157, @event.day
    end

    should "week" do
      assert_equal 165, @event.week
    end

    should "month" do
      assert_equal 39, @event.month
    end
  end

  context "after save callback" do
    setup do
      @event.save!
    end

    should "have created metrics" do
      [ HourlyMetric, DailyMetric, WeeklyMetric, MonthlyMetric ].each do |metric_class|
        assert_equal 1, metric_class.count
      end
    end

  end

end
