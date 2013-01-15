class PayloadsController < ApplicationController
  # GET /points/2/payloads
  # GET /points/2/payloads.json
  def index
    @point = Point.find(params[:point_id])
    @payloads = @point.payloads

    render json: @payloads
  end

  # GET /points/2/payloads/1
  # GET /points/2/payloads/1.json
  def show
    @point = Point.find(params[:point_id])
    @payload = @point.payloads.find(params[:id])

    render json: @payload
  end

  # POST /points/2/payloads
  # POST /points/2/payloads.json
  def create
    @point = Point.find(params[:point_id])
    @payload = @point.payloads.create(params[:payload])

    if @payload.save
      render json: @payload, status: :created, location: point_payloads_url(@payload)
    else
      render json: @payload.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /points/2/payloads/1
  # PATCH/PUT /points/2/payloads/1.json
  def update
    @point = Point.find(params[:point_id])
    @payload = @point.payloads.find(params[:id])

    if @payload.update_attributes(params[:payload])
      head :no_content
    else
      render json: @payload.errors, status: :unprocessable_entity
    end
  end

  # DELETE /points/2/payloads/1
  # DELETE /points/2/payloads/1.json
  def destroy
    @point = Point.find(params[:point_id])
    @payload = @point.payloads.find(params[:id])
    @payload.destroy

    head :no_content
  end
end
