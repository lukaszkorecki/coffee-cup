require_relative './models/user'
require_relative './models/coffee'
require_relative './models/counter'

# yay globals!
if not defined? COFFEES
  coffees = YAML::load_file './coffees.yml'
end

if not defined? USERS
  # lame
  users = begin
            JSON.parse ENV['USERS']
          rescue
            { 'dio' => { 'name' => 'Dio', 'face_url' => ''}, 'jojo' => { 'name' => 'JoJo', 'face_url' => ''}}
          end
end

class Collection
  def initialize collection
    @collection = collection
    @klass = :record
  end

  def find_by_name name
    all.find { |item| item.name == name }
  end


  def all
    @all ||= @collection.values.map.with_index do |item, index|
      @klass.new index, item['name']
    end
  end

  def to_json
    @collection.values.to_json
  end

end

class CoffeeCollection  < Collection
  def initialize *args
    super
    @klass = Coffee
  end
end


class  UserCollection < Collection
  def initialize *args
    super
    @klass = User
  end
end

COFFEES = CoffeeCollection.new coffees
USERS = UserCollection.new users

COFFEE_COUNTER = Counter.new(REDIS)
