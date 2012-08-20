class UnifyTimeFields < ActiveRecord::Migration
  def change
    rename_column :hourly_metrics,  :hour,  :time_pointer
    rename_column :daily_metrics,   :day,   :time_pointer
    rename_column :weekly_metrics,  :week,  :time_pointer
    rename_column :monthly_metrics, :month, :time_pointer
  end
end
