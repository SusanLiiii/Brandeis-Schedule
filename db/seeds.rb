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
    time_info = [{"start_time" => "#{time}:00", "end_time" => "#{time}:30"}, {"start_time" => "#{time}:30", "end_time" => "#{time+1}:00"}]
  TimeBlock.import time_field, time_info
end
time_info = [{"start_time" => "23:00", "end_time" => "23:30"}, {"start_time" => "23:30", "end_time" => "0:00"}]
TimeBlock.import time_field, time_info

rooms = []
CSV.foreach("data/room.csv", headers: true) do |row|
  rooms << Room.new(row.to_h)
end
Room.import rooms
Room.create(location:"Null", name:"Null", capacity:0)

Organizer.create(name: "None", email: "calendar@brandeis.edu", password: '0000000')
Calendar.new(EventSchedule.all).update_calendar