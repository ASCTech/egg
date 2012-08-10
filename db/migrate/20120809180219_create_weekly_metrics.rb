class CreateWeeklyMetrics < ActiveRecord::Migration
  def change
    create_table :weekly_metrics do |t|
      t.references :measureable
      t.integer :week
      t.integer :count, :null => false, :default => 0

    end
    add_index :weekly_metrics, :measureable_id
  end
end
