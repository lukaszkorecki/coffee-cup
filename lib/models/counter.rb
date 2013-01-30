class Counter
  def initialize redis
    @redis = redis
  end

  def add user, coffee
    # store all coffees  and users in a set, just in case ;-)
    @redis.sadd "coffees", coffee.name
    @redis.sadd "users", user.name

    # increments
    @redis.incr "user_coffee_count:#{user.name}"
    @redis.incr "coffee_count:#{coffee.name}"
    @redis.incr "day_#{day_of_year_today}"

    # latest coffees
    @redis.lpush "latest_coffees", coffee.name


  end

  def all_stats
    {
      coffee_stats: coffee_stats,
      user_stats: user_stats,
      all_coffees: all_coffees,
      latest_coffees_stats: latest_coffees_stats,
      daily_stats: daily_stats
    }
  end

  def coffee_stats
    coffees = @redis.smembers("coffees").map do |coffee|
      {coffee => @redis.get("coffee_count:#{coffee}").to_i}
    end
  end

  def user_stats
    @redis.smembers("users").map do |user|
      { user => @redis.get("user_coffee_count:#{user}").to_i}
    end
  end

  def all_coffees
    @redis.smembers("coffees").reduce(0) do |count, coffee|
      count += @redis.get("coffee_count:#{coffee}").to_i
    end
  end

  def latest_coffees_stats(count=10)
    @redis.lrange("latest_coffees",0,count-1)
  end

  def daily_stats(range=1)
    (0..range).to_a.map do |day_index|
      day = day_of_year_today - day_index
      @redis.get("day_#{day}").to_i
    end

  end

  private
  def day_of_year_today
    Time.now.strftime("%j").to_i
  end
end
