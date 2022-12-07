class SpotsController < ApplicationController
  require 'date'
  def new
    @spot = Spot.new
  end

  def create
  end

  def index
    geocode = Geocoder.search(params[:address]).find { |r| r.data["address"]["country_code"] == "fr" }
    @address_lat = geocode.coordinates[0]
    @address_long = geocode.coordinates[1]
    results = FilterSpotsService.new(params[:difficulty], params[:wind_min], params[:wind_max], params[:time], @address_lat, @address_long, params[:perimeter]).call
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
    # @weathers = @spot.weathers.where(id: params[:weather_ids].split(" ")) if params[:weather_ids].present?
    @weathers = @spot.weathers_filtered_by_time(cookies[:weather_ids_only_time].split("&"))
    @good_weathers = @spot.weathers_filtered(cookies[:weather_ids_only_time].split("&"))
    # tous les weathers filtré par le time
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :address, :description, photos: [])
  end
end
