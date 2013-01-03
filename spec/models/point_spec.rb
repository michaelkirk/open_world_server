require 'spec_helper'

describe Point do
  describe '.create_from_params' do
    it "should build a point" do
      Point.should_receive(:create).with({ category: 'my_category',
                                           payload: 'my_payload',
                                           lonlat: "POINT(2.000000 1.000000)"}).and_return(mock_model(Point))

      Point.create_from_params({ category: 'my_category',
                                 payload: 'my_payload',
                                 latitude: '1',
                                 longitude: '2' })
    end

    it "should assign latitude longitude" do
      point = Point.create_from_params({ category: 'my_category',
                                         payload: 'my_payload',
                                         latitude: '1',
                                         longitude: '2' })
      point.latitude.should == 1
      point.longitude.should == 2
    end
  end

  describe "#as_json" do
    it "should decompose it's point into latitude and longitude" do
      point = Point.new(category: 'my_category',
                        payload: 'my_payload',
                        lonlat: 'POINT(2 1)')

      point.as_json.should == { 'point' => { 'category' => 'my_category',
                                             'payload' => 'my_payload',
                                             :latitude => 1.0,
                                             :longitude => 2.0 }}
    end
  end
end
