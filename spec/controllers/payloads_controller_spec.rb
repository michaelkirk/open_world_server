require 'spec_helper'

describe PayloadsController do

  let!(:point) { FactoryGirl.create(:point) }

  # This should return the minimal set of attributes required to create a valid
  # Payload. As you add validations to Payload, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      "payload_type" => 'my_type',
      "data" => 'my_data',
      "point_id" => "#{point.id}"
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PayloadsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all payloads as @payloads" do
      get :index, { :point_id => point.id }, valid_session
      assigns(:payloads).should eq(point.payloads)
    end
  end

  describe "GET show" do
    it "assigns the requested payload as @payload" do
      payload = point.payloads.first
      get :show, {:point_id => point.id, :id => payload.to_param}, valid_session
      assigns(:payload).should eq(payload)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Payload" do
        expect {
          post :create, {:point_id => point.id, :payload => valid_attributes}, valid_session
        }.to change(Payload, :count).by(1)
      end

      it "assigns a newly created payload as @payload" do
        post :create, {:point_id => point.id, :payload => valid_attributes}, valid_session
        assigns(:payload).should be_a(Payload)
        assigns(:payload).should be_persisted
      end

      it "responds with the created payload" do
        post :create, {:point_id => point.id, :payload => valid_attributes}, valid_session
        response.code.should == "201"
        response.body.should == assigns(:payload).to_json
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved payload as @payload" do
        # Trigger the behavior that occurs when invalid params are submitted
        Payload.any_instance.stub(:save).and_return(false)
        post :create, {:point_id => point.id, :payload => { "data" => nil }}, valid_session
        assigns(:payload).should be_a_new(Payload)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested payload" do
        payload = point.payloads.first
        # Assuming there are no other payloads in the database, this
        # specifies that the Payload created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Payload.any_instance.should_receive(:update_attributes).with(valid_attributes)
        put :update, {"point_id" => point.id, "id" => payload.to_param, "payload" => valid_attributes}, valid_session
      end

      it "assigns the requested payload as @payload" do
        payload = point.payloads.first
        put :update, {:point_id => point.id, :id => payload.to_param, :payload => valid_attributes}, valid_session
        assigns(:payload).should eq(payload)
      end

      it "redirects to the payload" do
        payload = point.payloads.first
        put :update, {:point_id => point.id, :id => payload.to_param, :payload => valid_attributes}, valid_session
        response.code.should == "204"
      end
    end

    describe "with invalid params" do
      it "assigns the payload as @payload" do
        payload = point.payloads.first
        # Trigger the behavior that occurs when invalid params are submitted
        Payload.any_instance.stub(:save).and_return(false)
        put :update, {:point_id => point.id, :id => payload.to_param, :payload => { "data" => nil }}, valid_session
        assigns(:payload).should eq(payload)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested payload" do
      payload = Payload.create! valid_attributes
      expect {
        delete :destroy, {:point_id => point.id, :id => payload.to_param}, valid_session
      }.to change(Payload, :count).by(-1)
    end

    it "redirects to the payloads list" do
      payload = Payload.create! valid_attributes
      delete :destroy, {:point_id => point.id, :id => payload.to_param}, valid_session
      response.code.should == "204"
    end
  end

end
