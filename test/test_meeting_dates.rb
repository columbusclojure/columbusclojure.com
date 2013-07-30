APP_LIB = File.expand_path(File.dirname(__FILE__) + '/../lib')
$LOAD_PATH.unshift(APP_LIB).uniq!

require 'minitest/autorun'
require 'meeting_dates'

class TestMeetingDates < Minitest::Test
  WEDNESDAY = 3
  def setup
    @next_meeting_date = MeetingDates.next.date
  end

  def test_next_meeting_is_wednesday
    assert_equal WEDNESDAY, @next_meeting_date.wday
  end

  def test_next_meeting_is_within_the_first_week
    assert_equal (@next_meeting_date - 7.days).month + 1, @next_meeting_date.month
  end

  def test_next_meeting_is_six_oclock
    assert_equal 18, @next_meeting_date.hour
    assert_equal 0, @next_meeting_date.min
  end
end
