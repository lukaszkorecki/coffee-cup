require 'yaml'
require 'json'
require './lib/redis'
require './lib/models'
require './lib/widgets'
require 'newrelic_rpm'

class CoffeeApp < Sinatra::Base

  set :public_folder, './public'

  get '/' do
    content_type :html
    erb :index
  end

  get '/coffees' do
    content_type :json
    COFFEES.to_json
  end

  get '/team' do
    content_type :json
    USERS.to_json
  end

  post '/update/:coffee/:user' do |coffee_name, user_name|
    content_type :json
    user = USERS.find_by_name  user_name
    coffee = COFFEES.find_by_name  coffee_name
    if user and coffee
      COFFEE_COUNTER.add user, coffee
      status 200
      body({ message: "ok!" }.to_json)
    else
      status 410
      body({ message: "no such user or coffee"}.to_json)
    end
  end

  post '/flush' do
     REDIS.flushdb
  end

  get '/api/stats' do
    content_type :json
    COFFEE_COUNTER.all_stats.to_json
  end

  get '/api/widget/funnel/coffee-stats' do
    content_type :json
    GeckoFunnelWidget.new(COFFEE_COUNTER.coffee_stats).response.to_json
  end

  get '/api/widget/funnel/user-stats' do
    content_type :json
    GeckoFunnelWidget.new(COFFEE_COUNTER.user_stats).response.to_json

  end

  get '/api/widget/number/daily-coffee' do
    content_type :json
    GeckoNumberWidget.new(COFFEE_COUNTER.daily_stats).response.to_json
  end

  get '/api/widget/number/total-coffees' do
    content_type :json
    GeckoNumberWidget.new([COFFEE_COUNTER.total_coffees]).response.to_json

  end
end
