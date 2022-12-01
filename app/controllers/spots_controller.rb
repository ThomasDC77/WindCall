class SpotsController < ApplicationController
  def new
    @spot = Spot.new
  end

  def create
  end

  def index
    @spots = Spot.all

    if params[:difficulty].present?
      @spots = @spots.where(difficulty: params[:difficulty])
    end

    if params[:wind_min].present? && params[:wind_max].present?
      @spots = @spots.joins(:weathers).where(weather: { force_wind: params[:wind_min]..params[:wind_max]})
    end

    if params[:time].present?
      if params[:time] ===quand le mec envoie today on la meteo du spot du jour
        3.day.from_now
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :address, :description, photos: [])
  end
end
