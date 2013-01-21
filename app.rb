require 'yaml'
require 'json'
require './lib/models'
class CoffeeApp < Sinatra::Base
  get '/' do
    content_type :html
    erb :index
  end

  get '/coffees' do
    content_type :json
    COFFEES.all.to_json
  end

  get '/team' do
    content_type :json
    USERS.all.to_json
  end

  post '/update/:coffee/:user' do |coffee_name, user_name|
    content_type :json
    user = USERS.find_by_name  user_name
    coffee = COFFEES.find_by_name  coffee_name
    if user and coffee
      COFFEE_COUNTER.add Coffee.new(coffee.values), User.new(user.values)
      status 200
      body({ message: "ok!" }.to_json)
    else
      status 410
      body({ message: "no such user or coffee"}.to_json)
    end
  end

  get '/stats' do
    content_type :json
    {
      user_stats: COFFEE_COUNTER.user_stats,
      coffee_stats: COFFEE_COUNTER.coffee_stats
    }.to_json
  end
end
