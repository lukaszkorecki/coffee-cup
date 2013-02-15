require_relative './models/user'
require_relative './models/coffee'
require_relative './models/counter'

# yay globals!
if not defined? COFFEES
  COFFEES = YAML::load_file './drinks.yml'
end

if not defined? USERS
  # lame
  USERS = begin
            JSON.parse ENV['USERS']
          rescue
            { 'dio' => { 'name' => 'Dio', 'face_url' => ''}, 'jojo' => { 'name' => 'JoJo', 'face_url' => ''}}
          end
end

# global stats object, which wraps redis stats
COFFEE_COUNTER = Counter.new(REDIS)

require_relative './collections'
