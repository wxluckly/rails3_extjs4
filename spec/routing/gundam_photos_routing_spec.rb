require "spec_helper"

describe GundamPhotosController do
  describe "routing" do

    it "routes to #index" do
      get("/gundam_photos").should route_to("gundam_photos#index")
    end

    it "routes to #new" do
      get("/gundam_photos/new").should route_to("gundam_photos#new")
    end

    it "routes to #show" do
      get("/gundam_photos/1").should route_to("gundam_photos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/gundam_photos/1/edit").should route_to("gundam_photos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/gundam_photos").should route_to("gundam_photos#create")
    end

    it "routes to #update" do
      put("/gundam_photos/1").should route_to("gundam_photos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/gundam_photos/1").should route_to("gundam_photos#destroy", :id => "1")
    end

  end
end
