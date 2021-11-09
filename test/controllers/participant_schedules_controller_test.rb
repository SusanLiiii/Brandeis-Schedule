require "test_helper"

class ParticipantSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @participant_schedule = participant_schedules(:one)
  end

  test "should get index" do
    get participant_schedules_url
    assert_response :success
  end

  test "should get new" do
    get new_participant_schedule_url
    assert_response :success
  end

  test "should create participant_schedule" do
    assert_difference('ParticipantSchedule.count') do
      post participant_schedules_url, params: { participant_schedule: { event_id: @participant_schedule.event_id, participant_id: @participant_schedule.participant_id } }
    end

    assert_redirected_to participant_schedule_url(ParticipantSchedule.last)
  end

  test "should show participant_schedule" do
    get participant_schedule_url(@participant_schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_participant_schedule_url(@participant_schedule)
    assert_response :success
  end

  test "should update participant_schedule" do
    patch participant_schedule_url(@participant_schedule), params: { participant_schedule: { event_id: @participant_schedule.event_id, participant_id: @participant_schedule.participant_id } }
    assert_redirected_to participant_schedule_url(@participant_schedule)
  end

  test "should destroy participant_schedule" do
    assert_difference('ParticipantSchedule.count', -1) do
      delete participant_schedule_url(@participant_schedule)
    end

    assert_redirected_to participant_schedules_url
  end
end
