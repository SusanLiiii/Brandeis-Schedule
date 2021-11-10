# Brandeis-Schedule

## Description

A scheduling app that monitors the availability of rooms and facilities or supplies such as monitors or chargers they have on Campus. Organizers are able to select from available rooms and time slots and make a request to create a new event. They can also see a list of supplies each room provides. After the event is generated, users are able to subscribe to the events if they are interested. The database will contain information about classes and events in different rooms. Users are able to subscribe to classes and events, and there will be an auto generated schedule based on their subscription. There will also be a friend feature, where users can add friends to other users, change the publicity of their schedule or part of their schedules.

## Github repository

To import the code, run

```sh
  git clone https://github.com/SusanLiiii/Brandeis-Schedule.git
```

## Visit the web

The heroku link for the web is https://peaceful-beyond-97112.herokuapp.com/

## Routes and Corresponding View Descriptions Documentation

- Event urls:

* List out all the events: /events
* List out event information: /events/1
* Search for Event urls: /events/search?
* Display All events card for search result: /events/do_search?name=Group&room=2&org=3&commit=Search
* Schedule a new event through searching for available rooms: /events/new?end_time=2021-11-10+08%3A00%3A00+-0500&event_date=2021-11-10&room_id=1&start_time=2021-11-10+08%3A00%3A00+-0500
* Schedule a new event through directly select a room: /events/new?room_id=1

- Room urls:

* List out all the rooms: /rooms
* List out room information: /rooms/1
* Search for Room urls: /rooms/search?
* Display All room card for search result: /rooms/do_search?name=Skyline&commit=Search
* Search for available rooms based on date and time: /rooms/search_available?
* Display search result for available rooms: /rooms/do_search_available?event_date%5Bdate%281i%29%5D=2021&event_date%5Bdate%282i%29%5D=11&event_date%5Bdate%283i%29%5D=10&time%5Bstart_time%281i%29%5D=2021&time%5Bstart_time%282i%29%5D=11&time%5Bstart_time%283i%29%5D=10&time%5Bstart_time%284i%29%5D=08&time%5Bstart_time%285i%29%5D=00&time%5Bend_time%281i%29%5D=2021&time%5Bend_time%282i%29%5D=11&time%5Bend_time%283i%29%5D=10&time%5Bend_time%284i%29%5D=08&time%5Bend_time%285i%29%5D=00&commit=Find+Available+Room

- Participant urls:

* Participant Login: /participants/login
* Participant Signup: /participants/signup
* Participant Information(Event Schedule): /participants/6
* Edit Participant Information(emails, name, password): /participants/6/edit
* Participant Logout: /participants/logout

- Organizer urls:

* Organizer Login: /organizers/login
* Organizer Signup: /organizers/signup
* Organizer Information(Event Schedule): /organizers/6
* Edit Organizer Information(emails, name, password): /organizers/6/edit
* Organizer Logout: /organizers/logout

## Project Stages

- (Done) Import all static information such as event and department from Brandeis website and Brandeis public calendar(https://www.brandeis.edu/events/), and create a "Hello World" UI that display all the data

- (Done) Allow users to subscribe to events and classes and auto-generate a schedule based on their subscription

- (Done) Allow organizers to create events from available rooms and time slots

- (Current) Refine the UI and refractor the code to make it look cleaner. Write complete test for the app

- Add class schedule to the datebase

- AI Algorithm to find participant potential interested events

- Friend-feature and publicity

## Model information

- Datamodel Diagram
  https://dbdiagram.io/d/6161f8cb940c4c4eec8d4c3f

## Database initialization

The database is generated from 3 json files in /data.
To import the data, run

```sh
  rails db:seed
```

## APIs and gem libraries

Use the icalendar gem to read icalendar files downloaded from Google Calendar and then parse them into event informations.
(Future implementations) Download live event calendar file from website instead of read it into database and then update every set period of time.

```sh
  gem 'icalendar', '2.7.1'
```

Use the following gems to read html files from website, scraped data and parse informations that is needed for the database.

```sh
  gem 'webdrivers', '~> 4.6'
  gem 'nokogiri', '~> 1.11', '>= 1.11.7'
  gem 'open-uri'
```
