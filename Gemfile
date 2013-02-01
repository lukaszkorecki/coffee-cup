source :rubygems

gem 'sinatra'
gem 'sass'
gem 'json'
gem 'thin'
if ENV['hiredis']
  gem "hiredis"
  gem "redis", :require => ["redis/connection/hiredis", "redis"]
else
  gem 'redis'
end


group :development do
  gem 'shotgun'
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry'
end

group :test do
  gem 'mock_redis'
  gem 'rspec'
end
