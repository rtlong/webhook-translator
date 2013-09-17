require 'active_support/core_ext/object/blank'

module Flowdock
  module TeamInbox
    class Channel
      include HTTParty
      base_uri "https://api.flowdock.com/v1/messages/team_inbox"

      def initialize(api_token)
        @api_token = api_token
      end
      attr_reader :api_token

      def handle_event(event)
        send Message.for_event(event)
      end

      private

      def send(message)
        self.class.post path,
          body: MultiJson.dump(message),
          headers: { 'Content-Type' => 'application/json' }
      end

      def path
        "/#{api_token}"
      end
    end

    class Message
      class RequiredAttributeMissingError < StandardError
        def initialize(name)
          @name = name
        end

        def message
          "#{@name} is a required attribute"
        end
      end

      def initialize(attrs={})
        @attributes = {}
        @attributes[:source] = attrs[:source]
        @attributes[:from_address] = attrs[:from_address]
        @attributes[:subject] = attrs[:subject]
        @attributes[:content] = attrs[:content]
        @attributes[:from_name] = attrs[:from_name]
        @attributes[:reply_to] = attrs[:reply_to]
        @attributes[:project] = attrs[:project]
        @attributes[:tags] = Array(attrs[:tags])
        @attributes[:link] = attrs[:link]

        verify_attribute! :source
        verify_attribute! :from_address
        verify_attribute! :subject
        verify_attribute! :content
      end

      def as_json
        @attributes
      end

      def format
        :html
      end

      def self.for_event(event)
        new(
          source: event.source,
          content: event.body,
          subject: event.subject,
          project: event.context,
          from_address: event.email,
          link: event.url,
          tags: event.tags,
        )
      end

      private

      def verify_attribute!(name)
        @attributes[name].present? or raise RequiredAttributeMissingError.new(name)
      end
    end
  end

  module Chat
    # not implemented yet
  end
end
