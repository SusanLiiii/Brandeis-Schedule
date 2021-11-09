class CreateParticipantSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :participant_schedules do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
