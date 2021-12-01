require "test_helper"

class CalendarTest < ActiveSupport::TestCase
  def setup
    @calendar = Calendar.new(EventSchedule.all)
  end

  def test_find_start_time
    assert_equal "12:00", @calendar.find_start_time(Time.parse("2021-11-22 12:12:58 -0500")).start_time
  end

  def test_find_end_time
    assert_equal "12:30", @calendar.find_end_time(Time.parse("2021-11-22 12:12:58 -0500")).end_time
  end

  def test_get_today
    travel_to Time.parse("2021-10-23 12:12:58 -0500") do
      assert_equal "event 1", @calendar.get_today.first.name
      assert_equal 1, @calendar.get_today.size
    end
  end

  def test_get_future
    travel_to Time.parse("2021-10-23 12:12:58 -0500") do
      assert_equal "event 2", @calendar.get_future.first.name
      assert_equal 1, @calendar.get_future.size
    end

    travel_to Time.parse("2021-10-22 12:12:58 -0500") do
      assert_equal "event 2", @calendar.get_future.first.name
      assert_equal "event 1", @calendar.get_future.second.name
      assert_equal 2, @calendar.get_future.size
    end

    travel_to Time.parse("2021-10-24 12:12:58 -0500") do
      assert_equal 0, @calendar.get_future.size
    end
  end

  def test_get_past
    travel_to Time.parse("2021-10-24 12:12:58 -0500") do
      assert_equal "event 1", @calendar.get_past.first.name
      assert_equal 1, @calendar.get_past.size
    end

    travel_to Time.parse("2021-10-25 12:12:58 -0500") do
      assert_equal "event 2", @calendar.get_past.first.name
      assert_equal "event 1", @calendar.get_past.second.name
      assert_equal 2, @calendar.get_past.size
    end

    travel_to Time.parse("2021-10-23 12:12:58 -0500") do
      assert_equal 0, @calendar.get_past.size
    end  
  end

  def test_get_by_date
    assert_equal "event 1", @calendar.get_by_date(Time.parse("2021-10-23 12:12:58 -0500")).first.name
    assert_equal 1, @calendar.get_by_date(Time.parse("2021-10-23 12:12:58 -0500")).size
  end

  def test_get_by_event_name
    assert_equal "event 1", @calendar.get_by_event_name("event 1").first.name
    assert_equal 1, @calendar.get_by_event_name("event 1").size
  end

  def test_get_by_event_name_not_found
    assert_equal 0, @calendar.get_by_event_name("event 4").size
  end

  def test_check_room_availability
    assert @calendar.check_room_availability(Room.first.id, Time.parse("2021-10-23 12:12:58 -0500"), Time.parse("2021-10-23 12:12:58 -0500"), Time.parse("2021-10-23 13:45:58 -0500"))
  end

  def test_check_room_availability_not_available
    assert_not @calendar.check_room_availability(Room.first.id, Time.parse("2021-10-24 12:12:58 -0500"), Time.parse("2021-10-23 12:12:58 -0500"), Time.parse("2021-10-23 13:45:58 -0500"))
  end

  def test_find_available_rooms
    assert_equal 'room 2', @calendar.find_available_rooms(Time.parse("2021-10-23 12:12:58 -0500"), Time.parse("2021-10-23 12:12:58 -0500"), Time.parse("2021-10-23 13:45:58 -0500")).first.name
    assert_equal 1, @calendar.find_available_rooms(Time.parse("2021-10-23 12:12:58 -0500"), Time.parse("2021-10-23 12:12:58 -0500"), Time.parse("2021-10-23 13:45:58 -0500")).size
  end

  def test_get_current_event
    travel_to Time.parse("2021-10-23 11:12:58 -0500") do
      assert_equal "event 1", @calendar.get_current_event.first.event.name
      assert_equal 1, @calendar.get_current_event.size
    end
  end

  def test_get_current_event_not_found
    travel_to Time.parse("2021-10-24 11:12:58 -0500") do
      assert_equal 0, @calendar.get_current_event.size
    end
  end

  def test_get_next_event
    travel_to Time.parse("2021-10-23 11:12:58 -0500") do
      assert_equal "event 2", @calendar.get_next_event.first.event.name
      assert_equal 1, @calendar.get_next_event.size
    end
  end

  def test_get_next_event_not_found
    travel_to Time.parse("2021-10-25 11:12:58 -0500") do
      assert_equal 0, @calendar.get_next_event.size
    end
  end
end