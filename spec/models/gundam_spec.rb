require 'spec_helper'

describe Gundam do

  it "should have only one model per period" do
    period = Period.new(:name => 'test')
    g1 = Gundam.create(:model => "001", :period => period)
    g2 = Gundam.create(:model => "001", :period => period)
    g2.id.should == nil
  end
end

