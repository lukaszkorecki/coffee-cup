class GeckoFunnelWidget
  def initialize data_set
    @data_set = data_set
    @template = { 'percentage' => 'hide', 'item' => [] }
  end

  def response
    @template['item'] = @data_set.map {|item| { "value" => item.values.first, "label" => item.keys.first } }
    @template
  end
end
