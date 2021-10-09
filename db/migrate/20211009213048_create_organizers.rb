class CreateOrganizers < ActiveRecord::Migration[6.1]
  def change
    create_table :organizers do |t|
      t.string :name
      t.string :email
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
