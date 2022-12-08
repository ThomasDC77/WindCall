module ApplicationHelper
  def display_well_time(time)
    "#{time.hour}h"
  end

  def criteria_correspond?(weather)
    cookies[:weather_ids].gsub('[', "").gsub("]", "").split(", ").map(&:to_i).include?(weather.id)
  end

  def difficulty_level(spot_difficulty)
    case spot_difficulty
    when "Débutant"
      "level-beginning"
    when "Intermédiaire"
      "level-intermediate"
    when "Confirmé"
      "level-confirm"
    when "Expert"
      "level-expert"
    end
  end

  def first_good_weather_direction(spot)
    spot.weathers.where(id: cookies[:weather_ids_only_time]).first.wind_direction
  end

  def translate_day(day)
    trad_hash = {
      monday: "Lundi",
      tuesday: "Mardi",
      wednesday: "Mercredi",
      thursday: "Jeudi",
      friday: "Vendredi",
      saturday: "Samedi",
      sunday: "Sunday"

    }
    trad_hash[day.downcase.to_sym]
  end

  def translate_month(month)
    trad_hash = {
      january: "Janvier",
      february: "Février",
      march: "Mars",
      april: "Avril",
      may: "Mai",
      june: "Juin",
      july: "Juillet",
      august: "Août",
      september: "Septembre",
      october: "Octobre",
      november: "Novembre",
      december: "Décembre"
    }
    trad_hash[month.downcase.to_sym]
  end
end
