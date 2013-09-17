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

    def email
      @data.commit.author_email
    end

    def actor_name
      @data.commit.author_name
    end

    protected

    def commit_sha
      @data.commit.id[0..6]
    end

    def commit_summary
      commit_message = @data.commit.message.split("\n", 2).first
      '%s [%s] <%s>' % [commit_message, commit_sha, @data.commit.author_name]
    end

  end

  class BuildEvent < BaseEvent
    def subject
      'Build %s: %s #%s' % [result, @data.branch_name, @data.build_number]
    end

    def body
      '[%s/%s] Build #%s: %s' % [ @data.project_name, @data.branch_name, @data.build_number, commit_summary ]
    end

    def url
      @data.build_url
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
      '[%s] Deploy #%s: %s' % [ @data.server_name, @data.number, commit_summary ]
    end

    def url
      @data.html_url
    end

    def tags
      ['deploy', @data.server_name, @data.project_name]
    end

  end
end

