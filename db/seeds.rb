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

rooms = []
CSV.foreach("data/room.csv", headers: true) do |row|
  rooms << Room.new(row.to_h)
end
Room.import rooms

Organizer.create(name: "None", email: "calendar@brandeis.edu", password: '0000000')
event_data = Icalendar::Calendar.parse(URI.open("https://www.trumba.com/calendars/brandeis-university.ics"))
events = event_data.first.events
event_field = ["name", "description", "organizer_id"]
events.each do |event|
  event_info = { "name" => event.summary.to_s.gsub(/&#*\w+;/, ""), "description" => event.description.to_s.gsub(/&#*\w+;/, ""), "organizer_id" => 1}
  custom_property_list = event.to_ical.split("\r\nX-TRUMBA-CUSTOMFIELD")[1..]
  custom_property_list[-1] = custom_property_list[-1].split("\r\nX-TRUMBA-LINK")[0];
  custom_property_list.each do |custom_property|
    if custom_property.include? "NAME=Room"
      room_name = custom_property.split("TYPE=SingleLine:")[-1].gsub(/\r\n /, "").gsub(/\\/, "")
      room_location = event.location.to_s
      if !Room.where("rooms.location LIKE ?", "%#{room_location}%").size().zero?
        if !Room.where(location: room_location).where("rooms.name LIKE ?", "%#{room_name}%").size().zero?
          room_id = Room.where(location: room_location).where("rooms.name LIKE ?", "%#{room_name}%")[0].id
        else
          room = Room.create(location: room_location, name: room_name)
          room_id = room.id
        end
      else
        Room.create(location: room_location, name:room_name)
      end
    elsif custom_property.include? "NAME=Event sponsor(s)"
      organizer = custom_property.split("TYPE=MultiLine:")[-1].gsub(/\r\n /, "").gsub(/\\/, "").gsub(/&#*\w+;/, "")
      puts organizer
      if !Organizer.where("organizers.name LIKE ?", "%#{organizer}%").size().zero?
        organizer = Organizer.where("organizers.name LIKE ?", "%#{organizer}%")[0]
      else
        organizer = Organizer.create(name: organizer, email: "contact@brandeis.edu", password: "0000000")
      end
      event_info["organizer_id"] = organizer.id 
    end
  end
  Event.import event_field, [event_info]
end
