class EventEmitter
  def initialize
    @listeners = []
  end

  attr_reader :listeners

  def emit(event)
    listeners.each do |listener|
      listener.handle_event(event)
    end
  end

  def add_listener(listener)
    listeners << listener
  end
end
