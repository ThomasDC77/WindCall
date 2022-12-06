class PagesController < ApplicationController
  def home
    @spots = Spot.first(4)
  end
end
