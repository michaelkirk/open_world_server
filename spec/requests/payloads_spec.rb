require 'spec_helper'

describe "Payloads" do
  describe "POST /points/1/payloads" do
    it "should attach another payload to the point" do
      pending
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get points_payloads_path
      response.status.should be(200)
    end
  end

  describe "GET /points/1/payloads/4" do
    it "should returnthe payload JSON" do
      pending
    end
  end

  describe "DELETE /points/1/payloads/4" do
    it "should delete that payload from the point" do
      pending
    end
  end
end
