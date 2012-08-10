class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :measureable
      t.datetime :timestamp
      t.boolean :processed

      t.timestamps
    end
    add_index :events, :measureable_id
  end
end
