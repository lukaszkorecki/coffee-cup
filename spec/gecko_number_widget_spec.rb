require 'spec_helper'

describe  "Geckoboard Number widget thingie" do

  let :set do
     [30, 20]
  end

  let :widget do
    { "item" => [ { "value" => 30, "label" => "" }, { "value" => 20 , "label" => "" } ] }
  end

  it "produces a valid geckoboard number widget data" do

    GeckoNumberWidget.new(set).response.should == widget
  end
end
