require_relative 'spec_helper'
require 'flowdock'
require 'basic_event'

module Flowdock::TeamInbox

  describe Channel do
    let(:api_token) { 'blah' }

    subject(:channel) { described_class.new(api_token) }

    describe '#api_token' do
      subject { channel.api_token }
      it { should eq api_token }
    end

    describe '#handle_event' do
      let(:event) do
        ::BasicEvent.new(
          source: 'Foobar',
          body: 'Foo to the bar to the foo',
          subject: 'foobared',
          email: 'blah@foo.com'
        )
      end
      it 'should make a POST to flowdock' do
        request = stub_request(:post, "#{described_class.base_uri}/#{api_token}")
        .with(
          body: Message.for_event(event).as_json,
          headers: {content_type: 'application/json'})

        channel.handle_event(event)
        expect(request).to have_been_made
      end

    end
  end

  describe Message do
    describe '#initialize' do
      let(:attrs) do
        {
          source: 'source',
          from_address: 'from_address',
          subject: 'subject',
          content: 'content',
          from_name: 'Name',
          reply_to: 'address',
          projects: 'dsadd',
          tags: %w[thing1 thing2],
          link: 'dasdd'
        }
      end

      it 'should accept correct params' do
        described_class.new(attrs)
      end

      describe 'required attributes' do
        [:source, :from_address, :subject, :content].each do |name|

          context "missing #{name}" do
            before do
              attrs.delete(name)
            end
            it 'should raise an error' do
              expect { described_class.new(attrs) }.to raise_exception
            end
          end
        end
      end
    end

  end
end
