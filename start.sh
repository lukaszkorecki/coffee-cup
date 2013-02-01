env USERS=`ruby -ryaml -rjson -e "puts YAML::load_file('users.yml').to_json"` bundle exec rackup $*
