class CreateDailyMetrics < ActiveRecord::Migration
  def change
    create_table :daily_metrics do |t|
      t.references :measureable
      t.integer :day
      t.integer :count, :null => false, :default => 0

    end
    add_index :daily_metrics, :measureable_id
  end
end
