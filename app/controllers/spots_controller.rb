class SpotsController < ApplicationController
  def new
    @spot = Spot.new
  end

  def create
  end

  def index
    spots = Spot.all
    spots.each do |spot|
      if spot == Venue.near([@spot.latitude, @spot.longitude], @perimetre, units: :km)
        return spot
      end
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
