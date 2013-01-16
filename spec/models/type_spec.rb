require 'spec_helper'

describe Type do
  before do
    @type = Type.create(:name => "foobar")
  end

  it "name is repeat" do
    Type.create!(:name => "foobar").should_not be_valid
  end
end
