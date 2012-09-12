class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name_n
      t.string :emplid

      t.timestamps
    end
  end
end
