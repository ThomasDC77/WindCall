class PagesController < ApplicationController
  def home
    @spots = Spot.first(3)
  end
end
