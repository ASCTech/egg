class CreateMeasureables < ActiveRecord::Migration
  def change
    create_table :measureables do |t|
      t.string :service
      t.string :name

      t.timestamps
    end
  end
end
