class CreateEventSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :event_schedules do |t|
      t.references :event, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.references :time_block, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
