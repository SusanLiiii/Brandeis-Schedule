require "application_system_test_case"

class EventSchedulesTest < ApplicationSystemTestCase
  setup do
    @event_schedule = event_schedules(:one)
  end

  test "visiting the index" do
    visit event_schedules_url
    assert_selector "h1", text: "Event Schedules"
  end

  test "creating a Event schedule" do
    visit event_schedules_url
    click_on "New Event Schedule"

    fill_in "Date", with: @event_schedule.date
    fill_in "Event", with: @event_schedule.event_id
    fill_in "Room", with: @event_schedule.room_id
    fill_in "Time block", with: @event_schedule.time_block_id
    click_on "Create Event schedule"

    assert_text "Event schedule was successfully created"
    click_on "Back"
  end

  test "updating a Event schedule" do
    visit event_schedules_url
    click_on "Edit", match: :first

    fill_in "Date", with: @event_schedule.date
    fill_in "Event", with: @event_schedule.event_id
    fill_in "Room", with: @event_schedule.room_id
    fill_in "Time block", with: @event_schedule.time_block_id
    click_on "Update Event schedule"

    assert_text "Event schedule was successfully updated"
    click_on "Back"
  end

  test "destroying a Event schedule" do
    visit event_schedules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Event schedule was successfully destroyed"
  end
end
