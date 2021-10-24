class Room < ApplicationRecord
  has_many :event_schedules
  has_many :events
  has_many :time_blocks, through: :event_schedules
end
