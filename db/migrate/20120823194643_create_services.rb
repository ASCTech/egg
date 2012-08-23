class CreateServices < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.string :name
      t.string :key

      t.timestamps
    end
    add_column :measureables, :service_id, :integer
    Measureable.find_each do |measureable|
      service = Service.find_or_create_by_name measureable.service
      measureable.update_column :service_id, service.id
    end
    remove_column :measureables, :service

    add_index :measureables, :service_id
  end
end
