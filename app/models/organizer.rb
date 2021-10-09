class Organizer < ApplicationRecord
  belongs_to :department
  has_many :events
end
