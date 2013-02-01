class GeckoNumberWidget
  def initialize data_set
    @data_set = data_set
    @template = { "item" => [ ] }
  end

  def response
    @template['item'] = @data_set.map {|item| { "value" => item, "label" => "" } }
    @template
  end
end
