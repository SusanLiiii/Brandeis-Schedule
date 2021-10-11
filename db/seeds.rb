# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'icalendar'

department_data = JSON.parse(File.read('data/subject.json'))
department_field = ["id", "name"]
department_data.each do |department|
  department['id']['-'] = ''
  Department.import department_field, [department]
end

event_data = Icalendar::Calendar.parse(File.open("data/brandeis-university.ics"))
events = event_data.first.events
event_field = ["name", "description"]
events.each do |event|
  event_info = { "name" => event.summary.to_s, "description" => event.description.to_s }
  Event.import event_field, [event_info]
end