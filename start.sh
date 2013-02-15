export USERS=`ruby -ryaml -rjson -e "puts YAML::load_file('users.yml').to_json"`
# export PUSH_API_KEY=
export DAILY_COFFEE_NUMBER_KEY='widget key'
export TOTAL_COFFEE_NUMBER_KEY='widget key'
export USER_STATS_FUNNEL_KEY='widget key'
export COFFEE_STATS_FUNNEL_KEY='widget key'

bundle exec rackup $*
