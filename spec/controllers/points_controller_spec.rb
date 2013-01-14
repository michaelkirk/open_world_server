require 'spec_helper'

describe PointsController do
  describe '#create' do
    it "should create a point from lat/lon" do
      Point.should_receive(:create_from_params)

      post :create, { latitude: '1',
                      longitude: '2' }

      response.should be_success
    end
  end

  describe "#show" do
    it "should respond with a json representation" do
      point = Point.new(payloads_attributes: [{ data: "my_data" }], lonlat: "POINT(1 2)")
      Point.should_receive(:find).with('1').and_return(point)

      get :show, { id: '1' }
    
      response_json = JSON.parse response.body
      response_json['point']['payloads'][0]['data'].should == 'my_data'
    end
  end

  describe "#index" do
    it "should return points within bounding box" do
      Point.should_receive(:within_box).with('0', '1', '2', '3')
      get :index, { west: 0, south: 1, east: 2, north: 3 }
    end
  end

end
