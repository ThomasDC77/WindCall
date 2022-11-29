class SpotsController < ApplicationController
  def new
    @spot = Spot.new
  end

  def create
  end

  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
  end
end
