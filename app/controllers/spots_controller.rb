class SpotsController < ApplicationController
  require 'date'
  def new
    @spot = Spot.new
  end

  def create
  end

  def index
    @spots = Spot.all
    filter_by_difficulty
    filter_by_wind
    filter_by_time
    filter_by_address
    @spots = @spots.uniq
    @weathers_ids = @weathers.map(&:id)
  end

  def show
    @spot = Spot.find(params[:id])
    @weathers = @spot.weathers.where(id: params[:weathers_ids])
  end

  private

  def filter_by_difficulty
    return unless params[:difficulty].present?

    @spots = @spots.where(difficulty: params[:difficulty])
  end

  def filter_by_wind
    return unless params[:wind_min].present? && params[:wind_max].present?

    @weathers = Weather.where(wind_force: params[:wind_min]..params[:wind_max])
    @spots = @spots.joins(:weathers).where(weathers: { id: @weathers.map(&:id) })
  end

  def filter_by_time
    return unless params[:time].present?

    case params[:time]
    when "today"
      @weathers = @weathers.where(time: [DateTime.now.beginning_of_day..DateTime.now.end_of_day])
    when "tomorrow"
      @weathers = @weathers.where(time: [DateTime.tomorrow.beginning_of_day..DateTime.tomorrow.end_of_day])
    when "after"
      @weathers = @weathers.where(time: [2.days.from_now.beginning_of_day..2.days.from_now.end_of_day])
    end
    @spots = @spots.joins(:weathers).where(weathers: { id: @weathers.map(&:id) })
  end

  def filter_by_address
    return unless params[:address].present?

    geocode = Geocoder.search(params[:address]).find { |r| r.data["address"]["country_code"] == "fr" }
    lat = geocode.coordinates[0]
    long = geocode.coordinates[1]
    perimeter = params[:perimeter].present? ? params[:perimeter].to_i : 1000
    @spots = @spots.near([lat, long], perimeter)
  end

  def spot_params
    params.require(:spot).permit(:name, :address, :description, photos: [])
  end
end
