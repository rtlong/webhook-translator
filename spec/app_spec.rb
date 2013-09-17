require 'app'
require_relative 'spec_helper'

describe WebHookTranslator do
  it 'can be instantiated' do
    expect(WebHookTranslator.new).not_to be_nil
  end
end
