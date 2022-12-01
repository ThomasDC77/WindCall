class GetMeteoForSpotService
  def initialize(spot)
    @spot = spot
  end

  def call
    latitude = @spot.latitude.round(3)
    longitude = @spot.longitude.round(3)
    day = 0
    3.times do
      url = "https://api.meteo-concept.com/api/forecast/daily/#{day}/hourly?token=#{ENV["METEO_TOKEN"]}&hourly=true&latlng=#{latitude},#{longitude}"
      ap url
      url = URI(url)
      response = Net::HTTP.get(url)
      results = JSON.parse(response)
      day += 1

      if results["forecast"].present?
        results["forecast"].each do |hour|
          time = hour["datetime"]
          wind_force = hour["wind10m"]
          gust_wind = hour["gust10m"]
          wind_direction = hour["dirwind10m"]
          temperature = hour["temp2m"]
          prob_rain = hour["probarain"]
          prob_fog = hour["probafog"]
          weather = Weather.create(time:, wind_force:, gust_wind:, wind_direction:, temperature:, prob_rain:, prob_fog:)
          SpotWeather.create(spot: @spot, weather:)
        end
      end
    end
    # solve le cas ou l'api marche pas
    # solve le cas ou il n'y a pas toutes les infos
    # solve le cas ou il y a une erreur dans l'api (rate limit error)
    # begin rescue checker ce que ça fait
  end
end