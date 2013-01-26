require 'spec_helper'

describe "gundam_photos/index" do
  before(:each) do
    assign(:gundam_photos, [
      stub_model(GundamPhoto),
      stub_model(GundamPhoto)
    ])
  end

  it "renders a list of gundam_photos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
