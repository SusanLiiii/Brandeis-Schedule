class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.references :organizer, null: false, foreign_key: true
      
      t.timestamps
    end
    add_index :events, :name
  end
end
