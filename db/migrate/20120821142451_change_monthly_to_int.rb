class ChangeMonthlyToInt < ActiveRecord::Migration
  def up
    change_column :monthly_metrics, :time_pointer, :integer
  end

  def down
    change_column :monthly_metrics, :time_pointer, :string
  end
end
