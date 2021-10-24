class TimeBlock < ApplicationRecord
  has_many :event_schedules
  has_many :events, through: :event_schedules
  has_many :rooms, through: :event_schedules
end
