require 'spec_helper'
require 'log_channel'
require 'basic_event'

describe LogChannel do
  let(:stream) { double('stream', flush: nil) }

  let(:event) do
    ::BasicEvent.new(
      source: 'Foobar',
      body: 'Foo to the bar to the foo',
      subject: 'foobared',
      email: 'blah@foo.com'
    )
  end

  subject(:channel) { described_class.new(stream) }

  it_behaves_like 'a Channel'

  describe '#handle_event' do
    it 'puts to the IO stream passed in at initialization' do
      expect(stream).to receive(:puts).at_least(1).times
      channel.handle_event(event)
    end
  end

end
