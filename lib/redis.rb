require 'redis'
opts = if ENV['REDIS_HOST'] and ENV['REDIS_PORT']
         puts "Connecting to remote redis!"
         { host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'] }
       else
         nil
       end
REDIS = opts ? ::Redis.new(opts) : ::Redis.new
