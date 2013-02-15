require 'yaml'
require 'json'
require './lib/redis'
require './lib/push_info'
require './lib/models'
require './lib/widgets'
require './lib/stats_updater'
require './lib/gecko_pusher'

class CoffeeApp < Sinatra::Base

  set :public_folder, './public'

  before do
    @coffees = CoffeeCollection.new COFFEES
    @users = UserCollection.new USERS

  end

  get '/' do
    content_type :html
    erb :index
  end

  get '/coffees' do
    content_type :json
    @coffees.to_json
  end

  get '/team' do
    content_type :json
    @users.to_json
  end

  post '/update/:coffee/:user' do |coffee_name, user_name|
    content_type :json
    user = @users.find_by_name  user_name
    coffee = @coffees.find_by_name  coffee_name

    updater = StatsUpdater.new(user, coffee, COFFEE_COUNTER)
    did_update = updater.update!

    if did_update
      if PUSH_KEY
        gecko_pusher = GeckoPusher.new PUSH_KEY

        # TODO FIXME dry it, move it somewhere else
        gecko_pusher.add(PUSH_WIDGETS.coffee_stats_key, :funnel,  COFFEE_COUNTER.coffee_stats) if PUSH_WIDGETS.coffee_stats_key
        gecko_pusher.add(PUSH_WIDGETS.user_stats_key, :funnel,  COFFEE_COUNTER.user_stats) if PUSH_WIDGETS.user_stats_key
        gecko_pusher.add(PUSH_WIDGETS.daily_coffee_key, :number, COFFEE_COUNTER.daily_stats) if PUSH_WIDGETS.daily_coffee_key
        gecko_pusher.add(PUSH_WIDGETS.total_coffee_key, :number, COFFEE_COUNTER.total_coffees) if PUSH_WIDGETS.total_coffee_key

        gecko_pusher.push!
      end

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
