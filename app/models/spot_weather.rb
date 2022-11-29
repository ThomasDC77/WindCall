class SpotWeather < ApplicationRecord
  belongs_to :spot
  belongs_to :weather
end
