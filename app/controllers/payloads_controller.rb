class PayloadsController < ApplicationController
  # GET /payloads
  # GET /payloads.json
  def index
    @payloads = Payload.all

    render json: @payloads
  end

  # GET /payloads/1
  # GET /payloads/1.json
  def show
    @payload = Payload.find(params[:id])

    render json: @payload
  end

  # POST /payloads
  # POST /payloads.json
  def create
    @payload = Payload.new(params[:payload])

    if @payload.save
      render json: @payload, status: :created, location: point_payloads_url(@payload)
    else
      render json: @payload.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payloads/1
  # PATCH/PUT /payloads/1.json
  def update
    @payload = Payload.find(params[:id])

    if @payload.update_attributes(params[:payload])
      head :no_content
    else
      render json: @payload.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payloads/1
  # DELETE /payloads/1.json
  def destroy
    @payload = Payload.find(params[:id])
    @payload.destroy

    head :no_content
  end
end
