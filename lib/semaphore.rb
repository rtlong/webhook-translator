require 'active_support/string_inquirer'

module Semaphore
  class BaseEvent
    def initialize(attrs)
      @data = Hashie::Mash.new(attrs)
    end

    def source
      'Semaphore'
    end

    def context
      @data.project_name
    end

    def tags
      []
    end

    def result
      ActiveSupport::StringInquirer.new(@data.result)
    end
  end

  class BuildEvent < BaseEvent
    def subject
      'Build %s: %s #%s' % [result, @data.branch_name, @data.build_number]
    end

    def body
      '%s %s #%s %s %s %s' % [ @data.project_name, @data.branch_name, @data.build_number, @data.commit.message, @data.commit.id, @data.commit.author_name ]
    end

    def url
      @data.build_url
    end

    def email
      @data.commit.author_email
    end

    def tags
      ['build', @data.branch_name, @data.project_name]
    end

  end

  class DeployEvent < BaseEvent

    def subject
      'Deploy %s: %s #%s' % [result, @data.server_name, @data.number]
    end

    def body
      '%s #%s %s %s %s' % [ @data.server_name, @data.number, @data.commit.message, @data.commit.id, @data.commit.author_name ]
    end

    def url
      @data.html_url
    end

    def email
      @data.commit.author_email
    end

    def tags
      ['deploy', @data.server_name, @data.project_name]
    end

  end
end

