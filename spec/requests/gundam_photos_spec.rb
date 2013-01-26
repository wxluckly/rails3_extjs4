require 'spec_helper'

describe "GundamPhotos" do
  describe "GET /gundam_photos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get gundam_photos_path
      response.status.should be(200)
    end
  end
end
