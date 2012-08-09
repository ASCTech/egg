class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :measureable
      t.datetime :happened_at
      t.boolean :processed

      t.timestamps
    end
    add_index :events, :measureable_id
  end
end
