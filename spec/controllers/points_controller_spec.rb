require 'spec_helper'

describe PointsController do
  describe '#create' do
    it "should create a point from lat/lon" do
      Point.should_receive(:create_from_params)

      post :create, { type: 'my_type',
                     payload: 'my_payload',
                     latitude: '1',
                     longitude: '2' }

      response.should be_success
    end
  end

  describe "#show" do
    it "should respond with a json representation" do
      point = Point.new("type" => "my_type", "payload" => "my_payload", "lonlat" => "POINT(1 2)")
      Point.should_receive(:find).with('1').and_return(point)

      get :show, { id: '1' }
    
      response_json = JSON.parse response.body
      response_json['point']['payload'].should == 'my_payload'
    end
  end

end
