source :rubygems

gem 'sinatra'
gem 'sass'
gem 'json'
gem 'thin'

gem "hiredis", "~> 0.3.1"
gem "redis", "~> 2.2.0", :require => ["redis/connection/hiredis", "redis"]


group :development do
  gem 'shotgun'
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry'
end

group :test do
  gem 'fakeredis', :require => "fakeredis/rspec"
  gem 'rspec'
end
