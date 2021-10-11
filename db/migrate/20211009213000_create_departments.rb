class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
    # add_index :departments, :name
  end
end
