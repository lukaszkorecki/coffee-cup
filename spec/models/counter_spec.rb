require 'spec_helper'

describe  'Counter' do

  let :jojo do
    User.new(1, 'JoJo')
  end

  let :dio do
    User.new(2, 'Dio')
  end

  let :mocha do
    Coffee.new(1, "mocha")
  end

  let :latte do
    Coffee.new(2, 'latte')
  end

  subject { Counter.new MockRedis.new }

  it 'returns coffee stats' do
    subject.add jojo, mocha
    subject.add jojo, mocha
    subject.add dio, latte

    subject.coffee_stats.should == [
      {'latte' =>  1 },
      {'mocha' =>  2 }
    ]

  end

  it "returns user stats" do
    subject.add jojo, mocha
    subject.add jojo, mocha
    subject.add dio, latte

    subject.user_stats.should == [
      {'Dio' =>  1  },
      {'JoJo' =>  2  }
    ]

  end
end
