require 'spec_helper'

describe "Points Requests" do
  describe "POST /points" do
    it "should create a point and return the new point JSON" do
      request_body = FactoryGirl.build(:point).as_json
      post points_url, request_body
      response.status.should == 201
      # location should be like http://www.example.com/points/123
      response.location.should match(/^http:\/\/www\.example\.com\/points\/\d+$/)
      verify_point_json(JSON.parse(response.body))
    end
  end

  def verify_point_json(json)
    json["point"].should be_a(Hash)
    point = json["point"]
    point["latitude"].should == 1.0
    point["longitude"].should == 2.0
    point["id"].should be_a(Integer)

    point["payloads"].should be_a(Array)
    payload = point["payloads"][0]
    payload["payload_type"].should == "some_type"
    payload["data"].should == "some data"
  end

  describe "GET /points/1" do
    it "should return the point JSON" do
      point = FactoryGirl.build(:point, id: 1)

      Point.should_receive(:find).with('1').and_return(point)
      get point_url(1)
      verify_point_json(JSON.parse(response.body))
    end
  end

  describe "GET /points?west=0&south=1&east=2&north=3" do
    it "should return the points within the specified box" do
      point_within_box = FactoryGirl.build(:point, id: 3)
      Point.should_receive(:within_box).and_return([point_within_box]) 
      get points_url(west: "0", south: "1", east: "2", north: "3")
      verify_point_json(JSON.parse(response.body)[0])
    end

    it "should error when missing any of west, south, east, or north parameters" do
      Point.should_not_receive(:within_box)
      get points_url(west: 0)
      response.should_not be_success
      response.status.should == 501
    end
  end

  describe "DELETE /points/1" do
    it "should delete that point and all it's payloads" do
      mock_point = mock_model(Point)
      Point.should_receive(:find).with('1').and_return(mock_point)
      mock_point.should_receive(:destroy)

      delete point_url(1)
    end
  end
end
