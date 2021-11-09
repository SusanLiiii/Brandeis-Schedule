class Event < ApplicationRecord
  belongs_to :organizer
  belongs_to :room
  has_many :event_schedules
  has_many :time_blocks, through: :event_schedules
  has_many :participant_schedules
  has_many :participants, through: :participant_schedules
end