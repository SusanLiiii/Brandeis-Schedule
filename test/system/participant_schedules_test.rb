require "application_system_test_case"

class ParticipantSchedulesTest < ApplicationSystemTestCase
  setup do
    @participant_schedule = participant_schedules(:one)
  end

  test "visiting the index" do
    visit participant_schedules_url
    assert_selector "h1", text: "Participant Schedules"
  end

  test "creating a Participant schedule" do
    visit participant_schedules_url
    click_on "New Participant Schedule"

    fill_in "Event", with: @participant_schedule.event_id
    fill_in "Participant", with: @participant_schedule.participant_id
    click_on "Create Participant schedule"

    assert_text "Participant schedule was successfully created"
    click_on "Back"
  end

  test "updating a Participant schedule" do
    visit participant_schedules_url
    click_on "Edit", match: :first

    fill_in "Event", with: @participant_schedule.event_id
    fill_in "Participant", with: @participant_schedule.participant_id
    click_on "Update Participant schedule"

    assert_text "Participant schedule was successfully updated"
    click_on "Back"
  end

  test "destroying a Participant schedule" do
    visit participant_schedules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Participant schedule was successfully destroyed"
  end
end
