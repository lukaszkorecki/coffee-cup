require_relative './models/user'
require_relative './models/coffee'
require_relative './models/counter'

# yay globals!
if not defined? COFFEES
  coffees = YAML::load_file './coffees.yml'
end

if not defined? USERS
  users = YAML::load_file './users.yml'
end

class Collection
  def initialize collection
    @collection = collection
  end

  def find_by_name name
    @collection.values.find { |c| c['name'] == name }
  end


  def all
    @collection
  end

end
class CoffeeCollection  < Collection
end


class  UserCollection < Collection
end

COFFEES = CoffeeCollection.new coffees
USERS = UserCollection.new users

COFFEE_COUNTER = Counter.new
