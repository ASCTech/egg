class CreateMonthlyMetrics < ActiveRecord::Migration
  def change
    create_table :monthly_metrics do |t|
      t.references :measureable
      t.string :month
      t.integer :count

      t.timestamps
    end
    add_index :monthly_metrics, :measureable_id
  end
end
