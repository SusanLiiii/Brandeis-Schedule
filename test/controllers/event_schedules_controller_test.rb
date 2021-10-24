require "test_helper"

class EventSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_schedule = event_schedules(:one)
  end

  test "should get index" do
    get event_schedules_url
    assert_response :success
  end

  test "should get new" do
    get new_event_schedule_url
    assert_response :success
  end

  test "should create event_schedule" do
    assert_difference('EventSchedule.count') do
      post event_schedules_url, params: { event_schedule: { date: @event_schedule.date, event_id: @event_schedule.event_id, room_id: @event_schedule.room_id, time_block_id: @event_schedule.time_block_id } }
    end

    assert_redirected_to event_schedule_url(EventSchedule.last)
  end

  test "should show event_schedule" do
    get event_schedule_url(@event_schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_schedule_url(@event_schedule)
    assert_response :success
  end

  test "should update event_schedule" do
    patch event_schedule_url(@event_schedule), params: { event_schedule: { date: @event_schedule.date, event_id: @event_schedule.event_id, room_id: @event_schedule.room_id, time_block_id: @event_schedule.time_block_id } }
    assert_redirected_to event_schedule_url(@event_schedule)
  end

  test "should destroy event_schedule" do
    assert_difference('EventSchedule.count', -1) do
      delete event_schedule_url(@event_schedule)
    end

    assert_redirected_to event_schedules_url
  end
end
