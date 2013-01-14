require 'spec_helper'

describe Type do
  it "includes articles published less than one week ago" do
    type = Type.create!(:published_at => Date.today - 1.week + 1.second)
    expect(Type.recent).to eq([type])
  end
end
