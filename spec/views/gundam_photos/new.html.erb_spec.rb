require 'spec_helper'

describe "gundam_photos/new" do
  before(:each) do
    assign(:gundam_photo, stub_model(GundamPhoto).as_new_record)
  end

  it "renders new gundam_photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => gundam_photos_path, :method => "post" do
    end
  end
end
