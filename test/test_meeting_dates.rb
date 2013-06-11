APP_LIB = File.expand_path(File.dirname(__FILE__) + '/../lib')

$LOAD_PATH.unshift(APP_LIB).uniq!

require 'minitest/autorun'
require 'meeting_dates'

class TestMeetingDates < Minitest::Test
  def setup
    @next_meeting_date = MeetingDates.new.next.date
  end

  def test_next
    assert @next_meeting_date.wednesday?
    assert_equal 18, @next_meeting_date.hour
    assert_equal 0, @next_meeting_date.min
  end
end
