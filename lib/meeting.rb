class Meeting
  attr_accessor :date, :speakers, :fotm

  def initialize(date = Time.now.beginning_of_day)
    @date     = date
    @speakers = []
    @fotm     = []
  end
end
