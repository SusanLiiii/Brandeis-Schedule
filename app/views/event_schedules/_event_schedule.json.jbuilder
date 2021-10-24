json.extract! event_schedule, :id, :event_id, :room_id, :time_block_id, :date, :created_at, :updated_at
json.url event_schedule_url(event_schedule, format: :json)
