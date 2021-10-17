class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
    add_index :participants, :email, unique: true
  end
end
