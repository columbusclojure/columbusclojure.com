APP_LIB = File.expand_path(File.dirname(__FILE__) + '/../lib')

$LOAD_PATH.unshift(APP_LIB).uniq!

require 'minitest/autorun'
require 'meeting_dates'

class TestMeetingDates < Minitest::Test
  def setup
    @subject = MeetingDates.new
  end

  def test_next
    assert @subject.next.date.wednesday?
    assert_equal 18, @subject.next.date.hour
    assert_equal 0, @subject.next.date.min
  end
end
