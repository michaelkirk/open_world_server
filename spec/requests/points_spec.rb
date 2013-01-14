require 'spec_helper'

describe "Points Requests" do
  describe "POST /points" do
    it "should create a point and return the new point JSON" do

      request_body = { "point" => {
        "latitude" => 23.0,
        "longitude" => 45.0,
        "payloads" => [{ 
          "payload_type" => "photo", 
          "data" => 'my data'
        }]
      }}

      post points_url, request_body

      response.status.should == 201
      # location should be like http://www.example.com/points/123
      response.location.should match(/^http:\/\/www\.example\.com\/points\/\d+$/)

      # verify essential elements of the body
      json_body = JSON.parse(response.body)
      json_body["point"].should_not be_nil
      point = json_body["point"]
      point["latitude"].should == 23.0
      point["longitude"].should == 45.0
      point["id"].should be_a(Integer)
      point["payloads"].should_not be_nil
      point["payloads"].should be_a(Array)
      payload = point["payloads"][0]
      payload["payload_type"].should == "photo"
      payload["data"].should == "my data"
    end
  end

  describe "GET /points/1" do
    it "should return the point JSON" do
      pending
    end
  end

  describe "GET /points?west=0&south=1&east=2&north=3" do
    it "should return the points within the specified box" do
      pending
    end
  end

  describe "DELETE /points/1" do
    it "should delete that point and all it's payloads" do
      pending
    end
  end
end
