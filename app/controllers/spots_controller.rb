class SpotsController < ApplicationController
  require 'date'
  def new
    @spot = Spot.new
  end

  def create
  end

  def index
    results = FilterSpotsService.new(params[:difficulty], params[:wind_min], params[:wind_max], params[:time], params[:address], params[:perimeter]).call
    @spots = results[:spots]
    @weathers = results[:weathers]
    @weather_ids = results[:weather_ids]
  end

  def show
    @spot = Spot.find(params[:id])
    @weathers = @spot.weathers.where(id: params[:weather_ids].split(" ")) if params[:weather_ids].present?
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :address, :description, photos: [])
  end
end
