class StatsUpdater
  def initialize  user, coffee, stats_object
    @coffee = coffee
    @user = user
    @stats_object = stats_object
  end

  def update!
    if @user and @coffee
      @stats_object.add @user, @coffee
      yield if block_given?
      true
    else
      false
    end
  end
end
