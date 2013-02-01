require 'spec_helper'

describe  'Geckoboard Funnel widget thingie' do

  let :example_set do
    [ { 'latte' => 1 }, { 'mocha' => 3 } ]
  end

  let :example_funnel do
    {
    'percentage' =>  'hide',
      'item' => [
        { 'value' => 1, 'label' => 'latte' },
        { 'value' => 3, 'label' => 'mocha' }
    ]

    }
  end

  subject { GeckoFunnelWidget.new example_set }

  it 'generates a valid funnel widget data' do
    subject.response.should == example_funnel

  end
end
