class CreateHourlyMetrics < ActiveRecord::Migration
  def change
    create_table :hourly_metrics do |t|
      t.references :measureable
      t.integer :hour
      t.integer :count

      t.timestamps
    end
    add_index :hourly_metrics, :measureable_id
  end
end
