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
    # tous les spots filtrés
    @weathers = results[:weathers]
    # toutes les weathers filtrées
    cookies[:weather_ids] = results[:weather_ids].split("&")
    # on stock les weathers filtrés dans les cookies pour pouvoir les récupérer
    cookies[:weather_ids_only_time] = results[:weather_ids_only_time]
    # On stock toutes les weathers juste filtrée par time
  end

  def show
    @spot = Spot.find(params[:id])
    @weathers = @spot.weathers.where(id: cookies[:weather_ids_only_time].split("&"))
    # tous les weathers filtré par le time
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :address, :description, photos: [])
  end
end
