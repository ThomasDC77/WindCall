class PagesController < ApplicationController
  def home
    @spots = Spot.all
  end
end
