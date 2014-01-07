require 'minitest/autorun'
require 'meeting_date_calculator'
require 'timecop'

class TestMeetingDateCalculator < Minitest::Test
  def test_next_meeting_is_wednesday
    next_meeting = MeetingDateCalculator.next
    assert_equal MeetingDateCalculator::WEDNESDAY, next_meeting.wday
  end

  def test_next_meeting_is_next_month
    Timecop.freeze(Time.new(2013, 8, 10)) do
      next_meeting = MeetingDateCalculator.next
      assert_equal 9, next_meeting.month
    end
  end

  def test_next_meeting_is_this_month
    Timecop.freeze(Time.new(2013, 8, 1)) do
      next_meeting = MeetingDateCalculator.next
      assert_equal 8, next_meeting.month
      assert_equal 7, next_meeting.day
    end
  end

  def test_next_meeting_is_today
    Timecop.freeze(Time.new(2013, 8, 7)) do
      next_meeting = MeetingDateCalculator.next
      assert_equal 8, next_meeting.month
      assert_equal 7, next_meeting.day
    end
  end

  def test_next_meeting_in_first_week_not_today
    Timecop.freeze(Time.new(2013, 9, 7)) do
      next_meeting = MeetingDateCalculator.next
      assert_equal 10, next_meeting.month
      assert_equal 2, next_meeting.day
    end
  end
end
