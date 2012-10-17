require 'spec_helper'

describe "gundams/show" do
  before(:each) do
    @gundam = assign(:gundam, stub_model(Gundam,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
