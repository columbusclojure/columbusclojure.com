APP_LIB = File.expand_path(File.dirname(__FILE__) + '/../lib')
$LOAD_PATH.unshift(APP_LIB).uniq!

require 'minitest/autorun'
require 'meeting_dates'
require 'timecop'

class TestMeetingDates < Minitest::Test
  def setup
    @next_meeting_date = MeetingDates.next.date
  end

  def test_next_meeting_is_wednesday
    assert_equal MeetingDates::WEDNESDAY, @next_meeting_date.wday
  end

  def test_next_meeting_is_six_oclock
    assert_equal 18, @next_meeting_date.hour
    assert_equal 0, @next_meeting_date.min
  end

  def test_next_meeting_is_today
    Timecop.freeze(Time.new(2013, 8, 7)) do
      assert_equal 8, MeetingDates.next.date.month
      assert_equal 7, MeetingDates.next.date.day
    end
    Timecop.return
  end

  def test_next_meeting_is_within_the_first_week
    Timecop.freeze(Time.new(2013, 8, 1)) do
      assert_equal 8, MeetingDates.next.date.month
      assert_equal 7, MeetingDates.next.date.day
    end
    Timecop.return
  end

  def test_next_meeting_is_next_month
    Timecop.freeze(Time.new(2013, 8, 10)) do
      assert_equal 9, MeetingDates.next.date.month
    end
    Timecop.return
  end
end
