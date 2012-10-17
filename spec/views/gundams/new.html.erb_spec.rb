require 'spec_helper'

describe "gundams/new" do
  before(:each) do
    assign(:gundam, stub_model(Gundam,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new gundam form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => gundams_path, :method => "post" do
      assert_select "input#gundam_name", :name => "gundam[name]"
    end
  end
end
