class CreateDailyMetrics < ActiveRecord::Migration
  def change
    create_table :daily_metrics do |t|
      t.references :measureable
      t.integer :day
      t.integer :count

      t.timestamps
    end
    add_index :daily_metrics, :measureable_id
  end
end
