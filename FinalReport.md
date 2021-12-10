# Brandeis Schedule App Final Report

A one stop shop for Brandeis Student Activities scheduling. This product allows student organizers to choose an available room and create a new event, and allow participants to view the event schedules and subscribe to events. We also allow mailling between organizers and participants, so that participants will receive notice from the organizers about their subscribed events.

## Technology

### Data seeding

- We imported data from the [calendar-subscription link](https://www.trumba.com/calendars/brandeis-university.ics) on [Brandeis Campus Calendar website](https://www.brandeis.edu/events/) and use an icalendar API through importing the [icalendar gem](https://github.com/icalendar/icalendar) to parse the data and text to get information about all Brandeis events and use that to generate our database. So all events shown on our app are live events at Brandeis

```
gem 'icalendar', '2.7.1'
```

```
event_data = Icalendar::Calendar.parse(URI.open("https://www.trumba.com/calendars/brandeis-university.ics"))
```

- We also scraped data from [Brandeis Student Activities room list](https://www.brandeis.edu/student-activities/clubs-organizations/club-support/event-support/capacities.html), and parse the html template to get a list of room names, locations and capacity.

```
  gem 'webdrivers', '~> 4.6'
  gem 'nokogiri', '~> 1.11', '>= 1.11.7'
  gem 'open-uri'
```

```
browser = Watir::Browser.new
browser.goto 'https://www.brandeis.edu/student-activities/clubs-organizations/club-support/event-support/capacities.html'
room_page = Nokogiri::HTML(browser.html)
browser.close

room_card = room_page.xpath("//div[contains(@class, 'table__scroll')]")
```

### Action Mailer

### Deployment and Tests

We deployed our app to Heroku and provide a sophisticated test on the custom Calendar Poro which provides most of the crucial functionality of our app.

## What We Did

### Data Scheme

- We created the model based on different resources scheduling a room may have such as rooms, time blocks.
- We also create model for two user types.
- Our [model diagram](https://dbdiagram.io/d/6161f8cb940c4c4eec8d4c3f)

### Account Set Up

We built role-based access control and distinguished the users as organizers and participants so that the page will be displayed different when ![unlogged-in](https://user-images.githubusercontent.com/64478834/145521846-32c365b2-e3ea-4c32-a5e3-412756bc8127.png), ![logged-in as organizers](https://user-images.githubusercontent.com/64478834/145521955-d337d99f-55e6-4772-83bb-41bce825a270.png), and ![logged-in as participants](https://user-images.githubusercontent.com/64478834/145522019-1faeaaa9-1c4f-4ac1-9953-7d6f566edadf.png)

### Functionalities for Participant users

<img width="1419" alt="Event Page for Participant" src="https://user-images.githubusercontent.com/64478834/145522089-6ead54c6-23ca-40e9-b6ab-ad250076d29d.png">

- We optimized the process of viewing campus-wide events by aggregateing all the happening events at Brandeis to one page, and sort by organizers, rooms, and date.
- We allow searching of a particular event or a type of event by providing filters from the search page.
- We allow participants to subscribe to events they are participanting and receive information about their subscribed events from corresponding organizers about event modification or cancellation.
- We provide participants an auto-generated event schedule based on their subscribed events.

<img width="1419" alt="Participant Schedule" src="https://user-images.githubusercontent.com/64478834/145522125-7e000837-2c11-47c3-8cae-06e4847c651b.png">

### Functionalities for Organizer users

<img width="1419" alt="Room Search" src="https://user-images.githubusercontent.com/64478834/145522171-986e6686-85b4-4138-9c38-8eb6f84d0640.png">

- We replaced the onerous procedure for scheduling a new event involving extensive human coordination across multiple departments to reserve rooms, find available time slots, and invite participants to a simple click.
- We keep track of all room at Brandeis on any events that's happening inside through designing and implementing an algorithm that checks the available time for a room on a given date, and whether a room is available under a give date and time
- We allow organizers to search for desired rooms and create a new events to our database, which they are later able to edit or cancel.
- We also allow organizers to see number of participants for their events, and they are able to send message to participants of an event on new updates to the event.

<img width="1416" alt="Event Information" src="https://user-images.githubusercontent.com/64478834/145522288-ac0ef8e2-8bab-480a-b07c-ba0842b7b2d0.png">

## Technical Difficulty and Solutions

### Data import

Problem:

- To import the event information from Brandeis calendar, we mostly call from the attributes of the calendar object constructed by the icalendar gem. However, there are several custom fields including location and event organizer, which appears in random order, so that we cannot just get the value through a fixed index from the list.
  <img width="936" alt="Event Custom Fields" src="https://user-images.githubusercontent.com/64478834/145522916-d1cff828-bd52-4efb-853b-a7cf8e97a049.png">
  Solution:
- We choose to convert the calendar object as plain text and parse the text to extract the information
  <img width="992" alt="Plain text of calendar object" src="https://user-images.githubusercontent.com/64478834/145523145-c58abc7b-70e9-499b-a24e-12d6a41869c8.png">

```
custom_property_list = event.to_ical.split("\r\nX-TRUMBA-CUSTOMFIELD")[1..]
  custom_property_list[-1] = custom_property_list[-1].split("\r\nX-TRUMBA-LINK")[0];
  custom_property_list.each do |custom_property|
    if custom_property.include? "NAME=Room"
      room = custom_property.split("TYPE=SingleLine:")[-1].gsub(/\r\n /, "").gsub(/\\/, "")
      ......
    elsif custom_property.include? "NAME=Event sponsor(s)"
      organizer = custom_property.split("TYPE=MultiLine:")[-1].gsub(/\r\n /, "").gsub(/\\/, "").gsub(/&#*\w+;/, "")
      ......
    end
  end
```

### Room Availability

<img width="697" alt="Screen Shot 2021-12-10 at 12 54 00 AM" src="https://user-images.githubusercontent.com/64478834/145524402-82972fca-c63b-41af-99c1-3f8352a4086e.png">

Problem:

- There are many events happening at different time in many different rooms everyday, and their time duration are also different. It is hard to keep track of all event information and room availability on one table while allowing easy search for room availability at a certain time block.
- It also makes controller test duplicated because a lot of the controller shares the same code to act with events.

Solution:

- We create two separate models of time block, and event-schedule.
- Time blocks divide a day into unit of 30 minutes and we have this as a column on the event-schedule table.
- Then we divide an event into multiple time blocks, each blocks of time stands for an entry on the event-schedule table.
- Therefore, we create a many-to-many relationship between the event and the event-schedule, to allow fast searching of room availability at one or many time blocks.
- We also create a black-box class called Calendar, in which we implement all the actions we need to search for an event or room through different filters such as date, time, organizers and etc. A lot of the controllers call methods directly from this class which makes the code the controller more readable and avoid duplicate testing.

```
class Calendar
......
  def find_start_time(start_time)
    ......
  end

  def find_end_time(end_time)
    ......
  end

  def get_today
    ......
  end

  def get_future
    ......
  end

  def get_past
    ......
  end

  def get_by_date(date)
    ......
  end

  def get_by_event_name(name)
    ......
  end

  def check_room_availability(room_id, date, start_time, end_time)
    ......
  end

  def find_available_rooms(date, start_time, end_time)
    ......
  end

  def get_current_event
    ......
  end

  def get_next_event
    ......
  end

end
```

## Contribution

- UI design and implementation: Jane Wang
- Back-end Implementation: Susan Li
