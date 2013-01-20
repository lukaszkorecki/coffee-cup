class Counter
  def initialize
    @user_counter = Hash.new([])
    @coffee_counter = Hash.new(0)

  end

  def add user, coffee
    @user_counter[user.name] << coffee.name
    @coffee_counter[coffee.name] += 1
  end

  def coffee_stats
    # sloooo
    @coffee_counter.sort_by {|k,v| v }.reverse.map { |k,v| {k => { count: v }} }
  end

  def user_stats
    @user_counter.sort_by { |k,v| v }.reverse.map { |k,v| { k => { count: v.count } } }
  end
end
