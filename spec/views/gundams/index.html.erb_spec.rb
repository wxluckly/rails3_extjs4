require 'spec_helper'

describe "gundams/index" do
  before(:each) do
    assign(:gundams, [
      stub_model(Gundam,
        :name => "Name"
      ),
      stub_model(Gundam,
        :name => "Name"
      )
    ])
  end

  it "renders a list of gundams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
