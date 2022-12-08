class GetMeteoForSpotService
  def initialize(spot)
    @spot = spot
  end

  def call
    return if @spot.latitude.nil? || @spot.longitude.nil?

    latitude = @spot.latitude.round(3)
    longitude = @spot.longitude.round(3)
    day = 0
    3.times do
      url = "https://api.meteo-concept.com/api/forecast/daily/#{day}/hourly?token=#{ENV["METEO_TOKEN"]}&hourly=true&latlng=#{latitude},#{longitude}"
      url = URI(url)
      response = Net::HTTP.get(url)
      results = JSON.parse(response)
      day += 1

      next unless results["forecast"].present?

      results["forecast"].each do |hour|
        time = hour["datetime"]
        wind_force_km = hour["wind10m"]
        wind_force = (wind_force_km / 1.852).round(0)
        gust_wind_km = hour["gust10m"]
        gust_wind = (gust_wind_km / 1.852).round(0)
        wind_direction = hour["dirwind10m"]
        temperature = hour["temp2m"]
        prob_rain = hour["probarain"]
        prob_fog = hour["probafog"]
        Weather.create(spot: @spot, time:, wind_force:, gust_wind:, wind_direction:, temperature:, prob_rain:, prob_fog:)
      end
    end
    # solve le cas ou l'api marche pas
    # solve le cas ou il n'y a pas toutes les infos
    # solve le cas ou il y a une erreur dans l'api (rate limit error)
    # begin rescue checker ce que ça fait
  end
end
