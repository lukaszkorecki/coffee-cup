require './lib/models/user'
require './lib/models/coffee'
require './lib/models/counter'
class CoffeeApp < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/coffees' do

  end

  get '/team' do

  end

  post '/update/:coffee/:user' do

  end

  get '/stats' do

  end
end
