class Room < ApplicationRecord
  has_many :event_schedules
  has_many :time_blocks, through: :event_schedule
  has_many :event, through: :event_schedule
end
