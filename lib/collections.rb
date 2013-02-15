class Collection
  def initialize collection
    @collection = collection
    @klass = :record
  end

  def find_by_name name
    all.find { |item| item.name == name }
  end


  def all
    @all ||= @collection.values.map.with_index do |item, index|
      @klass.new index, item['name']
    end
  end

  def to_json
    @collection.values.to_json
  end

end

class CoffeeCollection  < Collection
  def initialize *args
    super
    @klass = Coffee
  end
end


class UserCollection < Collection
  def initialize *args
    super
    @klass = User
  end
end


