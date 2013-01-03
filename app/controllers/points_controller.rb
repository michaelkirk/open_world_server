class PointsController < ApplicationController

  # GET /points.json
  def index
    @points = Point.all
  end

  # POST /points.json
  def create
    @point = Point.create_from_params(params)
    render :json => @point, :status => :created, :location => @point
  end

  # GET /points/1.json
  def show
    @point = Point.find(params[:id])
    render :json => @point
  end

  # PUT /points/1.json
  def update
    @point = Point.find(params[:id])
    @point.update_from_params(params)
    @point.save
  end

  # DELETE /points/1.json
  def destroy
    @point = Point.find(params[:id])
    @point.destroy
  end
end
