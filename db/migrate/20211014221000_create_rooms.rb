class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :location
      t.string :capacity

      t.timestamps
    end
    add_index :rooms, :name
    add_index :rooms, :location
  end
end
