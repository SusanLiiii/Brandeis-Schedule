class Calendar

  def initialize
    @calendar = EventSchedule.all
  end

  def set_today
    @calendar = @calendar.where(date: Date.today)
  end

  def set_future
    @calendar = @calendar.where("date > ?", Date.today)
  end

  def set_past
    @calendar = @calendar.where("date < ?", Date.today)
  end

  def set_by_date(date)
    @calendar = @calendar.where(date: date)
  end

  def set_by_event_name(name)
    @calendar = @calendar.where(event_id: Event.where("events.name LIKE ?", "%#{name}%").ids)
  end

  def check_room_availability(room_name, date, start_time, end_time)
    start_time_id = TimeBlock.where(start_time: "#{start_time.hour} #{start_time.min}").first.id
    end_time_id = TimeBlock.where(end_time: "#{end_time.hour} #{end_time.min}").first.id
    event_schedule = @calendar.where(date: date).where(room_id: Room.where("rooms.name LIKE ?", "%#{room_name}%").ids).where(time_block_id: start_time_id..end_time_id)
    return event_schedule.empty?
  end

  def find_available_rooms(date, start_time, end_time)
    start_time_id = TimeBlock.where(start_time: "#{start_time.hour} #{start_time.min}").first.id
    end_time_id = TimeBlock.where(end_time: "#{end_time.hour} #{end_time.min}").first.id
    room_in_use = @calendar.where(date: date).where(time_block_id: start_time_id..end_time_id).pluck(:room_id)
    return Room.where.not(id: room_in_use)
  end

