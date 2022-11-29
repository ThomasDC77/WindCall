class WeathersController < ApplicationController
  def new
    @weather = Weather.new
  end

  def create
  end

  def update
    @weathers = Weather.find(params[:id])
  end
end
