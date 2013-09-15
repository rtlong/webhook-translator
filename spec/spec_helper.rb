require 'bundler/setup'
Bundler.setup(:default, ENV.fetch('RACK_ENV', :development).to_sym)
Bundler.require

require 'pry'

require 'webmock/rspec'

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")

Dir[File.expand_path('../{support,shared_examples}/**/*.rb', __FILE__)].each do |file|
  require file
end

