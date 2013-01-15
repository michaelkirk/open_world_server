require 'spec_helper'

describe "Payloads" do
  let(:payload_attributes) { FactoryGirl.attributes_for(:payload) }
  let(:point) { FactoryGirl.create(:point) }

  def validate_payload_json(json)
    payload = json['payload']
    payload['id'].should be_a(Numeric)
    payload['data'].should be_a(String)
    payload['payload_type'].should be_a(String)
  end

  describe "POST /points/1/payloads" do
    it "should respond with the created payload's JSON" do
      post point_payloads_path(point), { 'payload' => payload_attributes }

      response.status.should be(201)
      validate_payload_json(JSON.parse(response.body))
    end
  end

  describe "GET /points/1/payloads/4" do
    it "should return the payload JSON" do
      get point_payload_url(point, point.payloads[0])

      response.should be_success
      validate_payload_json(JSON.parse(response.body))
    end
  end

  describe "DELETE /points/1/payloads/4" do
    it "should delete that payload from the point" do
      delete point_payload_url(point, point.payloads[0])
      response.should be_success
    end
  end
end
