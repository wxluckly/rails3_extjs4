require 'spec_helper'

describe VersionsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'merge'" do
    it "returns http success" do
      get 'merge'
      response.should be_success
    end
  end

end
