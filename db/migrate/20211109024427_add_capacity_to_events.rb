class AddCapacityToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :capacity, :integer
  end
end
