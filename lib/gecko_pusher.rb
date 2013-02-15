require 'geckoboard-push'
class GeckoPusher
  def initialize api_key
    @url = "https://push.geckoboard.com/v1/send/"
    ::Geckoboard::Push.api_key = api_key
    @queue = []
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
