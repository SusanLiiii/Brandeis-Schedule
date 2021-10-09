class Department < ApplicationRecord
  has_many :organizers
  has_many :events, through: :organizer
end