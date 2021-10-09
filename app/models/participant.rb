class Participant < ApplicationRecord
  has_many :student_schedules
  has_many :events, through: :student_schedule
end