require 'spec_helper'

describe "gundam_photos/edit" do
  before(:each) do
    @gundam_photo = assign(:gundam_photo, stub_model(GundamPhoto))
  end

  it "renders the edit gundam_photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => gundam_photos_path(@gundam_photo), :method => "post" do
    end
  end
end
