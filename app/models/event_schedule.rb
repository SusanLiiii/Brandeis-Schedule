class EventSchedule < ApplicationRecord
  belongs_to :time_block
  belongs_to :room
  belongs_to :event
end
