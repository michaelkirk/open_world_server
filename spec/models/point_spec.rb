require 'spec_helper'

describe Point do
  describe '.create_from_params' do
    it "should build a point" do
      Point.should_receive(:create).with({ payloads_attributes: [{payload_type: 'my_type', data: 'my_payload'}],
                                           lonlat: "POINT(2.000000 1.000000)"}).and_return(mock_model(Point))

      Point.create_from_params({ payloads: [{payload_type: "my_type", data: 'my_payload'}],
                                 latitude: '1',
                                 longitude: '2' })
    end

    it "should assign latitude longitude" do
      point = Point.create_from_params({ payloads: [{payload_type: "my_type", data: 'my_payload'}],
                                         latitude: '1',
                                         longitude: '2' })
      point.latitude.should == 1
      point.longitude.should == 2
    end
  end

  describe "#as_json" do
    it "should decompose it's point into latitude and longitude" do
      point = Point.new(payloads_attributes: [{payload_type: "my_type", data: 'my_payload'}],
                        lonlat: 'POINT(2 1)')

      expected_json = { 
        point: { 
          id: nil,
          payloads: [
            {
              payload_type: "my_type", 
              data: 'my_payload'
            }
          ],
          latitude: 1.0,
          longitude: 2.0 }}

      HashWithIndifferentAccess.new(point.as_json).should == HashWithIndifferentAccess.new(expected_json)
    end
  end

  describe ".within_box" do
    it "should return points whose latitude and longitude falls within the corners of the bounding box" do
      # some points grabbed from gmaps.
      southwest_corner =  "(-94.247318, 44.970218)"
      northeast_corner =  "(-93.242812, 44.972449)"
      in_box = "(-93.244035, 44.97128)"
      out_of_box = "(-93.249711, 44.973179)"

      point_in_box = Point.create_from_params( longitude: -93, latitude: 45)
      point_not_in_box = Point.create_from_params( longitude: -95, latitude:  45)

                      #( w,  s,  e,  n )
      Point.within_box(-94, 44, -92, 46).should == [point_in_box]
    end
  end
end
