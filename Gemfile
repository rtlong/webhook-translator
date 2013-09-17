ruby '2.0.0'

source "https://rubygems.org"

gem 'rake'
gem 'nyny'
gem 'multi_json'
gem 'oj'
gem 'thin'
gem 'hashie'
gem 'activesupport', require: false
gem 'httparty'

group :test, :development do
  gem 'rspec', require: false
  gem 'guard', require: false
  gem 'guard-rspec', require: false
end

group :test do
  gem 'webmock', require: false
end
group :development do
   gem 'pry'
end
