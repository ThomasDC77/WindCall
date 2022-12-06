module ApplicationHelper
  def display_well_time(time)
    "#{time.hour}h"
  end

  def criteria_correspond?(weather)
    cookies[:weather_ids].gsub('[', "").gsub("]", "").split(", ").map(&:to_i).include?(weather.id)
  end
end
