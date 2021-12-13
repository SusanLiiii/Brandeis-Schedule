# Brandeis-Schedule

## Description

A one stop shop for Brandeis Student Activities scheduling. This product updates events from Brandeis official calendar. It allows student organizers to choose an available room and create a new event, and allows participants to view the event schedules and subscribe to events. It also allows mailling between organizers and participants, so that participants can receives notice from the organizers about their subscribed events.

## Github repository

To import the code, run

```sh
  git clone https://github.com/SusanLiiii/Brandeis-Schedule.git
```

## Link to Final Report Page

The github page for the final report is https://susanliiii.github.io/Brandeis-Schedule/

## Visit the web

The heroku link for the web is https://cryptic-tor-08741.herokuapp.com/

## Routes and Corresponding View Descriptions Documentation

- Event urls:

* List out event information: [/events/1](https://cryptic-tor-08741.herokuapp.com/events/1)
* Event list page with search bar urls: [/events/search?](https://cryptic-tor-08741.herokuapp.com/events/search?)
* Schedule a new event through searching for available rooms: [/events/new?end_time=2021-11-10+08%3A00%3A00+-0500&event_date=2021-11-10&room_id=1&start_time=2021-11-10+08%3A00%3A00+-0500](https://cryptic-tor-08741.herokuapp.com/events/new?end_time=2021-11-10+08%3A00%3A00+-0500&event_date=2021-11-10&room_id=1&start_time=2021-11-10+08%3A00%3A00+-0500)
* Schedule a new event through directly select a room: [/events/new?room_id=1](https://cryptic-tor-08741.herokuapp.com/events/new?room_id=1)
* Edit an event: [/events/1/edit](https://cryptic-tor-08741.herokuapp.com/events/1/edit)

- Room urls:

* List out room information: [/rooms/1](https://cryptic-tor-08741.herokuapp.com/rooms/1)
* Room list page with search bar urls: [/rooms/search?](https://cryptic-tor-08741.herokuapp.com/rooms/search?)
* Display All room card for search result: [/rooms/do_search?location=Select+a+location&name=Dance+Studio&button=](https://cryptic-tor-08741.herokuapp.com/rooms/do_search?location=Select+a+location&name=Dance+Studio&button=)
* Search for available rooms based on date and time: [/rooms/search_available?](https://cryptic-tor-08741.herokuapp.com/rooms/search_available?)
* Display search result for available rooms: [/rooms/do_search_available?event_date%5Bdate%281i%29%5D=2021&event_date%5Bdate%282i%29%5D=11&event_date%5Bdate%283i%29%5D=10&time%5Bstart_time%281i%29%5D=2021&time%5Bstart_time%282i%29%5D=11&time%5Bstart_time%283i%29%5D=10&time%5Bstart_time%284i%29%5D=08&time%5Bstart_time%285i%29%5D=00&time%5Bend_time%281i%29%5D=2021&time%5Bend_time%282i%29%5D=11&time%5Bend_time%283i%29%5D=10&time%5Bend_time%284i%29%5D=08&time%5Bend_time%285i%29%5D=00&commit=Find+Available+Room](https://cryptic-tor-08741.herokuapp.com/rooms/do_search_available?event_date%5Bdate%281i%29%5D=2021&event_date%5Bdate%282i%29%5D=11&event_date%5Bdate%283i%29%5D=10&time%5Bstart_time%281i%29%5D=2021&time%5Bstart_time%282i%29%5D=11&time%5Bstart_time%283i%29%5D=10&time%5Bstart_time%284i%29%5D=08&time%5Bstart_time%285i%29%5D=00&time%5Bend_time%281i%29%5D=2021&time%5Bend_time%282i%29%5D=11&time%5Bend_time%283i%29%5D=10&time%5Bend_time%284i%29%5D=08&time%5Bend_time%285i%29%5D=00&commit=Find+Available+Room)

- Participant urls:

* Participant Login: [/participants/login](https://cryptic-tor-08741.herokuapp.com/participants/login)
* Participant Signup: [/participants/signup](https://cryptic-tor-08741.herokuapp.com/participants/signup)
* Participant Information(Event Schedule): [/participants/1](https://cryptic-tor-08741.herokuapp.com/participants/1)
* Participant Logout: [/logout](https://cryptic-tor-08741.herokuapp.com/logout)

- Organizer urls:

* Organizer Login: [/organizers/login](https://cryptic-tor-08741.herokuapp.com/organizers/login)
* Organizer Signup: [/organizers/signup](https://cryptic-tor-08741.herokuapp.com/organizers/signup)
* Organizer Information(Event Schedule): [/organizers/6](https://cryptic-tor-08741.herokuapp.com/organizers/6)
* Organizer Logout: [/logout](https://cryptic-tor-08741.herokuapp.com/logout)

## Project Stages

- (Done) Import all static information such as event and department from Brandeis website and Brandeis public calendar(https://www.brandeis.edu/events/), and create a "Hello World" UI that display all the data

- (Done) Allow users to subscribe or unscubscribe to events

- (Done) Allow organizers to create, edit or cancel events from available rooms and time slots

- (Done) Refine the UI and refractor the code to make it look cleaner. Write complete test for the app

- (Done) Allow participants to receive email notification about event information.

## Model information

- Datamodel Diagram
  https://dbdiagram.io/d/6161f8cb940c4c4eec8d4c3f

## Database initialization

The database is generated from 3 json files in /data.
To import the data, run

```sh
  rails db:seed
```

## APIs, gem libraries and technology used

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

Implement Action mailer to send email notification to participants and organizers about events.
