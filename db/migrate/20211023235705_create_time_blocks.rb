class CreateTimeBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :time_blocks do |t|
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
    add_index :time_blocks, :start_time
  end
end
