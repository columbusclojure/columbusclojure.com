require 'minitest/autorun'
require './lib/meeting_dates.rb'

class TestMeetingDates < Minitest::Test
  def setup
    @subject = MeetingDates.new
  end

  # def test_next
  #   assert_equal nil, @subject.next
  # end
end
