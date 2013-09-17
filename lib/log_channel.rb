class LogChannel

  def initialize(stream)
    @stream = stream
  end

  def handle_event(e)
    @stream.puts('========= New Event: =========')
    @stream.puts("[%s]\nSubject: %s\n\n%s" % [e.source, e.subject, e.body])
    @stream.flush
  end

end
