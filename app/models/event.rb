class Event < ApplicationRecord
  belongs_to :organizer
  belongs_to :room
  has_many :event_schedules
  has_many :time_blocks, through: :event_schedules
  # has_many :student_schedules
  # has_many :participants, through: :student_schedule
end