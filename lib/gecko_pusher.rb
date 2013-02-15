class GeckoPusher
  def initialize api_key
    @api_key = api_key
    @queue = []
  end

  # this is "hardcoded" here so that request handler is cleaner
  def setup push_widgets, stats
    add(push_widgets.coffee_stats_key, :funnel,  stats.coffee_stats) if push_widgets.coffee_stats_key
    add(push_widgets.user_stats_key, :funnel,  stats.user_stats) if push_widgets.user_stats_key
    add(push_widgets.daily_coffee_key, :number, stats.daily_stats) if push_widgets.daily_coffee_key
    add(push_widgets.total_coffee_key, :number, stats.total_coffees) if push_widgets.total_coffee_key

  end

  def add widget_key, type, widget_data
    @queue << [type, widget_key, widget_data]
  end

  def push!
    # FIXME threads? fibers? job queue?
    @queue.each do |type, key, data|
      post_to_gecko type, key, data
    end
  end

  private
  def post_to_gecko type, key, data
    ::Geckoboard::Push.api_key = @api_key

    case type
    when :funnel
      widget_data = GeckoFunnelWidget.new(data).response['item']
      ::Geckoboard::Push.new(key).funnel(widget_data)
    when :number
      fir, sec = data
      sec ||= 0
      ::Geckoboard::Push.new(key).number_and_secondary_value(fir,sec)
    end
  end
end
