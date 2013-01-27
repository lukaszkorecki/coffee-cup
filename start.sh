env USERS=`ruby -ryaml -rjson -e "puts YAML::load_file('geckos.yml').to_json"` bundle exec rackup
