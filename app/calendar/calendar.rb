class Calendar

  def initialize(event_schedule)
    @calendar = event_schedule
  end

  def find_start_time(start_time)
    time_block_start = TimeBlock.find_by(start_time: "#{start_time.hour} #{start_time.min}")

    if time_block_start.nil?
      min = start_time.min
      if min < 30
        time_block_start = TimeBlock.find_by(start_time: "#{start_time.hour} 0")
      else
        time_block_start = TimeBlock.find_by(start_time: "#{start_time.hour} 30")
      end
    end
    return time_block_start
  end

  def find_end_time(end_time)
    time_block_end = TimeBlock.find_by(end_time: "#{end_time.hour} #{end_time.min}")

    if time_block_end.nil?
      min = end_time.min
      if min < 30
        time_block_end = TimeBlock.find_by(end_time: "#{end_time.hour} 30")
      else
        time_block_end = TimeBlock.find_by(end_time: "#{end_time.hour+1} 0")
      end
    end
    return time_block_end
  end

  def get_today
    return Event.where(id: @calendar.where(date: Date.today).pluck(:event_id))
  end

  def get_future
    return Event.where(id: @calendar.where("date > ?", Date.today).pluck(:event_id))
  end

  def get_past
    return Event.where(id: @calendar.where("date < ?", Date.today).pluck(:event_id))
  end

  def get_by_date(date)
    return Event.where(id: @calendar.where(date: date).pluck(:event_id))
  end

  def get_by_event_name(name)
    return Event.where("events.name LIKE ?", "%#{name}%")
  end

  def check_room_availability(room_id, date, start_time, end_time)
    start_time_id = find_start_time(start_time)
    end_time_id = find_end_time(end_time)
    event_schedule = @calendar.where(date: date).where(room_id: room_id).where(time_block_id: start_time_id..end_time_id)
    return event_schedule.empty?
  end

  def find_available_rooms(date, start_time, end_time)
    start_time_id = find_start_time(start_time)
    end_time_id = find_end_time(end_time)
    room_in_use = @calendar.where(date: date).where(time_block_id: start_time_id.id .. end_time_id.id).pluck(:room_id)
    return Room.where.not(id: room_in_use)
  end

  def get_current_event
    return @calendar.where(date: Date.today).where(time_block_id: find_start_time(Time.now).id)
  end

  def get_next_event
    date = Date.today
    event = @calendar.where(date: date).where("time_block_id > ?", find_start_time(Time.now).id)
    while event.empty?
      if @calendar.where("date > ?", Date.today).empty?
        return []
      else
        date += 1
        event = @calendar.where(date: date).where("time_block_id > ?", 0)
      end
    end
    return event.where(time_block_id: event.first.time_block_id)
  end

end