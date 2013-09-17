require 'spec_helper'
require 'event_emitter'
require 'basic_event'

describe EventEmitter do

  subject { described_class.new }

  describe '#emit' do
    let(:listeners) do
      [
        double(handle_event: nil),
        double(handle_event: nil)
      ]
    end

    let(:event) do
      ::BasicEvent.new(
        source: 'Foobar',
        body: 'Foo to the bar to the foo',
        subject: 'foobared',
        email: 'blah@foo.com'
      )
    end

    before do
      listeners.each do |listener|
        subject.add_listener(listener)
      end
    end

    it 'calls `handle_event` on all listeners' do
      subject.emit(event)

      listeners.each do |listener|
        expect(listener).to have_received(:handle_event)
      end
    end

  end

  describe '#add_listener' do
    let(:listener) { double('listener') }

    it 'adds to the listeners collection' do
      subject.add_listener(listener)
      expect(subject.listeners).to include listener
    end
  end
end
