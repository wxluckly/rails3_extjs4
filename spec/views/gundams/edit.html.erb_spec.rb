require 'spec_helper'

describe "gundams/edit" do
  before(:each) do
    @gundam = assign(:gundam, stub_model(Gundam,
      :name => "MyString"
    ))
  end

  it "renders the edit gundam form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => gundams_path(@gundam), :method => "post" do
      assert_select "input#gundam_name", :name => "gundam[name]"
    end
  end
end
