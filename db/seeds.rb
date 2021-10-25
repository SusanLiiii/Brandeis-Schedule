# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'icalendar'
require 'csv'
require 'open-uri'

# department_data = JSON.parse(File.read('data/subject.json'))
# department_field = ["id", "name", "email", "password_digest"]
# department_data.each do |department|
#   department['id']['-'] = ''
#   department['name'] += " Department"
#   department['email'] = "calendar@brandeis.edu"
#   department['password'] = '0000000'
#   Organizer.import department_field, [department]
# end

time_field = ["start_time", "end_time"]
(0..22).each do |time|
    time_info = [{"start_time" => "#{time} 0", "end_time" => "#{time} 30"}, {"start_time" => "#{time} 30", "end_time" => "#{time+1} 0"}]
  TimeBlock.import time_field, time_info
end
time_info = [{"start_time" => "23 0", "end_time" => "23 30"}, {"start_time" => "23 30", "end_time" => "0 0"}]
TimeBlock.import time_field, time_info

rooms = []
CSV.foreach("data/room.csv", headers: true) do |row|
  rooms << Room.new(row.to_h)
end
Room.import rooms
Room.create(location:"Null", name:"Null", capacity:0)

Organizer.create(name: "None", email: "calendar@brandeis.edu", password: '0000000')
event_data = Icalendar::Calendar.parse(URI.open("https://www.trumba.com/calendars/brandeis-university.ics"))
events = event_data.first.events
events.each do |event|
  event_schedule_data = {"date" => event.dtstart.to_date}
  event_info = { "name" => event.summary.to_s.gsub(/&#*\w+;/, ""), "description" => event.description.to_s.gsub(/&#*\w+;/, ""), "organizer_id" => 1}

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
    time_block_start = TimeBlock.find_by(start_time: "#{event.dtstart.hour} #{event.dtstart.min}")
    time_block_end = TimeBlock.find_by(end_time: "#{event.dtend.hour} #{event.dtend.min}")

    if time_block_start.nil?
      min = event.dtstart.min
      if min < 30
        time_block_start = TimeBlock.find_by(start_time: "#{event.dtstart.hour} 0")
      else
        time_block_start = TimeBlock.find_by(start_time: "#{event.dtstart.hour} 30")
      end
    end
    if time_block_end.nil?
      min = event.dtend.min
      if min < 30
        time_block_end = TimeBlock.find_by(end_time: "#{event.dtend.hour} 30")
      else
        time_block_end = TimeBlock.find_by(end_time: "#{event.dtstart.hour+1} 0")
      end
    end
    event_schedule_data["start_time"] = time_block_start.id
    event_schedule_data["end_time"] = time_block_end.id
  end

  (event_schedule_data["start_time"]..event_schedule_data["end_time"]).each do |time_id|
    EventSchedule.create(time_block_id: time_id, event_id: event_schedule_data["event_id"], room_id: event_schedule_data["room_id"], date: event_schedule_data["date"])
  end
end
