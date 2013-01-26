require 'spec_helper'

describe "gundam_photos/show" do
  before(:each) do
    @gundam_photo = assign(:gundam_photo, stub_model(GundamPhoto))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
