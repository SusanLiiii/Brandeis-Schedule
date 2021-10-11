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

## Project Stages

- (Current) Import all static information such as event and department from Brandeis website and Brandeis public calendar(https://www.brandeis.edu/events/), and create a "Hello World" UI that display all the data

- Allow users to subscribe to events and classes and auto-generate a schedule based on their subscription

- Allow organizers to create events from available rooms and time slots

- Add class schedule to the datebase

- Friend-feature and publicity

## Database information

- Datamodel Diagram
  https://dbdiagram.io/d/6161f8cb940c4c4eec8d4c3f

## Database initialization

The database is generated from 3 json files in /data.
To import the data, run

```sh
  rails db:seed
```
