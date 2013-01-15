require "spec_helper"

describe PayloadsController do
  describe "routing" do

    it "routes to #index" do
      get("/points/2/payloads").should route_to("payloads#index", :point_id => "2")
    end

    it "routes to #new" do
      get("/points/2/payloads/new").should route_to("payloads#new", :point_id => "2")
    end

    it "routes to #show" do
      get("/points/2/payloads/1").should route_to("payloads#show", :point_id => "2", :id => "1")
    end

    it "routes to #edit" do
      get("/points/2/payloads/1/edit").should route_to("payloads#edit", :point_id => "2", :id => "1")
    end

    it "routes to #create" do
      post("/points/2/payloads").should route_to("payloads#create", :point_id => "2")
    end

    it "routes to #update" do
      put("/points/2/payloads/1").should route_to("payloads#update", :point_id => "2", :id => "1")
    end

    it "routes to #destroy" do
      delete("/points/2/payloads/1").should route_to("payloads#destroy", :point_id => "2", :id => "1")
    end

  end
end
