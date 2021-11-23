require "test_helper"

class CalendarTest < ActiveSupport::TestCase
  def setup
    @calendar = Calendar.new(EventSchedule.all)
  end

  def test_find_start_time
    assert_equal TimeBlock.first.start_time, @calendar.find_start_time(Time.parse("2021-11-22 12:12:58 -0500"))
  end

  def test_find_end_time
    assert_equal TimeBlock.first.end_time, @calendar.find_end_time(Time.parse("2021-11-22 12:12:58 -0500"))
  end
end