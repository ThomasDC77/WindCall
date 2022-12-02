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
    @weathers_ids = results[:weathers_ids]
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
    @weathers = @spot.weathers.where(id: params[:weathers_ids])
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :address, :description, photos: [])
  end
end
