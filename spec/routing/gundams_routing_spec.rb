require "spec_helper"

describe GundamsController do
  describe "routing" do

    it "routes to #index" do
      get("/gundams").should route_to("gundams#index")
    end

    it "routes to #new" do
      get("/gundams/new").should route_to("gundams#new")
    end

    it "routes to #show" do
      get("/gundams/1").should route_to("gundams#show", :id => "1")
    end

    it "routes to #edit" do
      get("/gundams/1/edit").should route_to("gundams#edit", :id => "1")
    end

    it "routes to #create" do
      post("/gundams").should route_to("gundams#create")
    end

    it "routes to #update" do
      put("/gundams/1").should route_to("gundams#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/gundams/1").should route_to("gundams#destroy", :id => "1")
    end

  end
end
