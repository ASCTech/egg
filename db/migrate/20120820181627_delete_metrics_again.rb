class DeleteMetrics < ActiveRecord::Migration
  def up
    HourlyMetric.delete_all
    DailyMetric.delete_all
    WeeklyMetric.delete_all
    MonthlyMetric.delete_all
    Delayed::Job.delete_all
    Event.update_all(:processed => false)
  end

end
