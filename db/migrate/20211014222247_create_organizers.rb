class CreateOrganizers < ActiveRecord::Migration[6.1]
  def change
    create_table :organizers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
    add_index :organizers, :name
  end
end
