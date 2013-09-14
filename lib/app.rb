require 'bundler/setup'
Bundler.setup(:default, ENV['RACK_ENV'].to_sym)
Bundler.require
require 'pry'

BOOT_TIME = Time.now

class BaseEvent
  def self.parse(json)
    new(MultiJson.load(json))
  end

  def self.register_listener(listener)
    listeners.push listener
  end

  def self.listeners
    @listeners ||= []
  end

  def initialize(event_data)
    @data = Hashie::Mash.new event_data
  end

  def to_html
    "<pre>#{MultiJson.dump(@data, pretty: true)}</pre>"
  end

  def to_s
    MultiJson.dump(@data, pretty: true)
  end

  def notify_listeners!
    self.class.listeners.each do |listener|
      listener.notify!(self)
    end
  end
end
module Semaphore
  class BuildEvent < BaseEvent
  end
  class DeployEvent < BaseEvent
  end
end

module Status
  def health_status
    {
      boot_time: BOOT_TIME.to_s
    }
  end
end

class WebHookTranslator < NYNY::App
  helpers Status

  after do
    p response
  end

  get '/' do
    MultiJson.dump(health_status)
  end

  post '/semaphore/build' do
    request.body.rewind
    event = Semaphore::BuildEvent.parse(request.body.read)
    event.notify_listeners!.count
  end
  post '/semaphore/deploy' do
    request.body.rewind
    event = Semaphore::DeployEvent.parse(request.body.read)
    event.notify_listeners!.count
  end

end

class StdOutNotifier
  def self.notify!(event)
    puts "EVENT: #{event.class.name} #{event.to_s}"
  end
end

BaseEvent.register_listener StdOutNotifier
Semaphore::DeployEvent.register_listener StdOutNotifier
Semaphore::BuildEvent.register_listener StdOutNotifier
