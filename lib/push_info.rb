require 'ostruct'
PUSH_WIDGETS = OpenStruct.new({
  coffee_stats_key: ENV['COFFEE_STATS_FUNNEL_KEY'],
  user_stats_key: ENV['USER_STATS_FUNNEL_KEY'],
  daily_coffee_key: ENV['DAILY_COFFEE_NUMBER_KEY'],
  total_coffee_key: ENV['TOTAL_COFFEE_NUMBER_KEY']
})

PUSH_KEY = ENV['PUSH_API_KEY']
