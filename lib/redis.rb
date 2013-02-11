require 'redis'
REDIS_OPTS = if ENV['REDIS_HOST'] and ENV['REDIS_PORT']
         puts "Connecting to remote redis!"
         { host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'],   password: ENV['REDIS_PASSWORD']}
       else
         nil
       end
REDIS = REDIS_OPTS ? ::Redis.new(REDIS_OPTS) : ::Redis.new
