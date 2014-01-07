class Meeting
  attr_reader :date, :speakers, :fotm

  def initialize(date, info={})
    @date     = date
    @speakers = info.fetch("speakers") rescue []
    @fotm     = info.fetch("fotm") rescue []
  end

  def no_speakers?
    @speakers.nil? or @speakers.empty?
  end

  def no_fotm?
    @fotm.nil? or @fotm.empty?
  end
end
