require 'bundler/setup'
Bundler.setup(:default, ENV.fetch('RACK_ENV', :development).to_sym)
Bundler.require

require 'pry'

require 'event_emitter'
require 'log_channel'
require 'flowdock'
require 'semaphore'
require 'helpers/json_io'
require 'helpers/status'

BOOT_TIME = Time.now

class WebHookTranslator < NYNY::App
  helpers Status, JsonIO

  before do
    @emitter = EventEmitter.new
    @emitter.add_listener LogChannel.new(STDOUT)
    if (token = ENV['FLOWDOCK_API_TOKEN'])
      @emitter.add_listener Flowdock::TeamInbox::Channel.new(token)
    end
  end

  get '/' do
    MultiJson.dump(health_status)
  end

  post '/semaphore/build' do
    event = Semaphore::BuildEvent.new(parse_request_body_as_json)
    @emitter.emit(event)
    'okay'
  end

  post '/semaphore/deploy' do
    event = Semaphore::DeployEvent.new(parse_request_body_as_json)
    @emitter.emit(event)
    'okay'
  end

end


