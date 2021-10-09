class CreateTimeBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :time_blocks do |t|
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
