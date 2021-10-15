class Event < ApplicationRecord
  belongs_to :organizer
  # has_many :event_schedules
  # has_many :student_schedules
  # has_many :participants, through: :student_schedule
end