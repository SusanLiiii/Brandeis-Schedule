require 'icalendar'

class Calendar

  # Search for events within given range
  def initialize(event_schedule)
    @calendar = event_schedule
  end

  def find_start_time(start_time)
    time_block_start = TimeBlock.find_by(start_time: "#{start_time.hour} #{start_time.min}")

    if time_block_start.nil?
      min = start_time.min
      if min < 30
        time_block_start = TimeBlock.find_by(start_time: "#{start_time.hour}:00")
      else
        time_block_start = TimeBlock.find_by(start_time: "#{start_time.hour}:30")
      end
    end
    return time_block_start
  end

  def find_end_time(end_time)
    time_block_end = TimeBlock.find_by(end_time: "#{end_time.hour} #{end_time.min}")

    if time_block_end.nil?
      min = end_time.min
      if min == 0
        time_block_end = TimeBlock.find_by(end_time: "#{end_time.hour}:00")
      elsif min <= 30
        time_block_end = TimeBlock.find_by(end_time: "#{end_time.hour}:30")
      else
        hour = end_time.hour + 1
        if hour == 24
          hour = 0
        end
        time_block_end = TimeBlock.find_by(end_time: "#{hour}:00")
      end
    end
    return time_block_end
  end

  def get_today
    return Event.where(id: @calendar.where(date: Date.today.in_time_zone("Eastern Time (US & Canada)").to_date).pluck(:event_id))
  end

  def get_future
    return Event.where(id: @calendar.where("date > ?", Date.today.in_time_zone("Eastern Time (US & Canada)").to_date).pluck(:event_id))
  end

  def get_past
    return Event.where(id: @calendar.where("date < ?", Date.today.in_time_zone("Eastern Time (US & Canada)").to_date).pluck(:event_id))
  end

  def get_by_date(date)
    return Event.where(id: @calendar.where(date: date).pluck(:event_id))
  end

  def get_by_event_name(name)
    return Event.where("events.name LIKE ?", "%#{name}%")
  end

  def check_room_availability(room_id, date, start_time, end_time)
    if Room.find(room_id).location == "Online" || Room.find(room_id).location == "Various Locations"
      return true
    end
    start_time_id = find_start_time(start_time).id
    end_time_id = find_end_time(end_time).id
    if start_time_id > end_time_id
      tmp = start_time_id
      start_time_id = end_time_id
      end_time_id = tmp
    end
    event_schedule = @calendar.where(date: date).where(room_id: room_id).where(time_block_id: start_time_id..end_time_id)
    return event_schedule.empty?
  end

  def find_available_rooms(date, start_time, end_time)
    start_time_id = find_start_time(start_time).id
    end_time_id = find_end_time(end_time).id
    if start_time_id > end_time_id
      tmp = start_time_id
      start_time_id = end_time_id
      end_time_id = tmp
    end
    room_in_use = @calendar.where(date: date).where(time_block_id: start_time_id .. end_time_id).pluck(:room_id)
    return Room.where.not(id: room_in_use)
  end

  def get_current_event
    return @calendar.where(date: Date.today.in_time_zone("Eastern Time (US & Canada)").to_date).where(time_block_id: find_start_time(DateTime.now.in_time_zone("Eastern Time (US & Canada)")).id)
  end

  def get_next_event
    date = Date.today.in_time_zone("Eastern Time (US & Canada)").to_date
    event = @calendar.where(date: date).where("time_block_id > ?", find_start_time(DateTime.now.in_time_zone("Eastern Time (US & Canada)")).id)
    while event.empty?
      if @calendar.where("date > ?", Date.today.in_time_zone("Eastern Time (US & Canada)").to_date).empty?
        return []
      else
        date += 1
        event = @calendar.where(date: date).where("time_block_id > ?", 0)
      end
    end
    return event.where(time_block_id: event.first.time_block_id)
  end

  def generate_calendar(event)
    start_time = event.event_schedules.first.time_block.start_time.split(":")
    end_time = event.event_schedules.last.time_block.end_time
    date = event.event_schedules.first.date

    cal = Icalendar::Calendar.new
    cal.event do |e|
      e.dtstart = Icalendar::Values::DateTime.new(DateTime.new date.year, date.month, date.day, start_time[0].to_i, start_time[1].to_i, 0)
      e.dtend = Icalendar::Values::DateTime.new(DateTime.new date.year, date.month, date.day, end_time[0].to_i, end_time[1].to_i, 0)
      e.summary = event.description
      e.location = "#{event.room.location}: #{event.room.name}"
    end
    return cal.to_ical
  end

  def update_calendar
    event_data = Icalendar::Calendar.parse(URI.open("https://www.trumba.com/calendars/brandeis-university.ics"))
    events = event_data.first.events
    events.each do |event|
      if Event.where(uid: event.uid.to_s).empty?
        event_schedule_data = {"date" => event.dtstart.to_date}
        event_info = { "uid" => event.uid.to_s, "name" => event.summary.to_s.gsub(/&#*\w+;/, ""), "description" => event.description.to_s.gsub(/&#*\w+;/, ""), "organizer_id" => 1}

        custom_property_list = event.to_ical.split("\r\nX-TRUMBA-CUSTOMFIELD")[1..]
        custom_property_list[-1] = custom_property_list[-1].split("\r\nX-TRUMBA-LINK")[0];
        custom_property_list.each do |custom_property|
          if custom_property.include? "NAME=Room"
            room = custom_property.split("TYPE=SingleLine:")[-1].gsub(/\r\n /, "").gsub(/\\/, "")
            room_location = event.location.to_s
            if !Room.where("rooms.location LIKE ?", "%#{room_location}%").size().zero?
              if !Room.where(location: room_location).where("rooms.name LIKE ?", "%#{room}%").size().zero?
                room = Room.where(location: room_location).where("rooms.name LIKE ?", "%#{room}%")[0]
              else
                room = Room.create(location: room_location, name: room)
              end
            else
              room = Room.create(location: room_location, name:room)
            end
            event_schedule_data["room_id"] = room.id
          elsif custom_property.include? "NAME=Event sponsor(s)"
            organizer = custom_property.split("TYPE=MultiLine:")[-1].gsub(/\r\n /, "").gsub(/\\/, "").gsub(/&#*\w+;/, "")
            if !Organizer.where("organizers.name LIKE ?", "%#{organizer}%").size().zero?
              organizer = Organizer.where("organizers.name LIKE ?", "%#{organizer}%")[0]
            else
              organizer = Organizer.create(name: organizer, email: "contact@brandeis.edu", password: "0000000")
            end
            event_info["organizer_id"] = organizer.id 
          end
        end

        if event_schedule_data["room_id"].nil?
          if event.location.nil?
            event_schedule_data["room_id"] = Room.find_by(location: "Null").id
          else
            room = Room.find_by(location: event.location.to_s)
            if room.nil?
              room = Room.create(location: event.location.to_s, name: event.location.to_s)
            end
            event_schedule_data["room_id"] = room.id
          end
        end

        event_info["room_id"] = event_schedule_data["room_id"]
        event_schedule_data["event_id"] = Event.create(event_info).id

        event_schedule_data["start_time"] = 1
        event_schedule_data["end_time"] = 48
        if event.dtstart.instance_of?(Icalendar::Values::DateTime)
          event_schedule_data["start_time"] = Calendar.new(EventSchedule.all).find_start_time(event.dtstart).id
          event_schedule_data["end_time"] = Calendar.new(EventSchedule.all).find_end_time(event.dtend).id
        end

        (event_schedule_data["start_time"]..event_schedule_data["end_time"]).each do |time_id|
          EventSchedule.create(time_block_id: time_id, event_id: event_schedule_data["event_id"], room_id: event_schedule_data["room_id"], date: event_schedule_data["date"])
        end
      end
    end
  end
end