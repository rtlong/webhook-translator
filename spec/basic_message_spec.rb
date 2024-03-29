require_relative 'spec_helper'
require 'basic_event'

describe BasicEvent do
  let(:attrs) do
    {
      source: 'the source',
      context: 'the context',
      subject: 'subject',
      body: 'body',
      url: 'url',
      email: 'email',
      actor_name: 'name',
      tags: %w[tag1 tag2]
    }
  end

  subject do
    described_class.new attrs
  end

  [:source, :context, :subject, :body, :url, :email, :tags].each do |name|
    its(name) { should eq(attrs[name]) }
  end

  it_behaves_like 'an Event'
end

