class CreateWeeklyMetrics < ActiveRecord::Migration
  def change
    create_table :weekly_metrics do |t|
      t.references :measureable
      t.integer :week
      t.integer :count

      t.timestamps
    end
    add_index :weekly_metrics, :measureable_id
  end
end
