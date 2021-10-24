class EventSchedule < ApplicationRecord
  belongs_to :event
  belongs_to :room
  belongs_to :time_block
end
