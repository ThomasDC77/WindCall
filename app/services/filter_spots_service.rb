class FilterSpotsService
  def initialize(difficulty, wind_min, wind_max, time, latitude, longitude, perimeter)
    @spots = Spot.all
    @difficulty = difficulty
    @wind_min = wind_min
    @wind_max = wind_max
    @time = time
    @latitude = latitude
    @longitude = longitude
    @perimeter = perimeter
  end

  def call
    filter_by_difficulty
    filter_by_time
    @weather_ids_only_time = @weathers.map(&:id)
    # on récupère les weathers juste filtrer par time et on les stock dans la variable qui est un tableau
    filter_by_wind
    filter_by_address
    @weather_ids = @weathers.map(&:id)
    # on récupère les weathers full filtrer et on les stock dans cette variable qui est un tableau
    @spots = @spots.joins(:weathers).where(weathers: { id: @weather_ids })
    # on récupère tous les spots qui ont la bonne météo de weather_ids
    { spots: @spots.uniq, weathers: @weathers, weather_ids: @weather_ids, weather_ids_only_time: @weather_ids_only_time }
    # grace a cette ligne on peut appeler les spots weathers... dans la méthode index du controller
  end

  def filter_by_difficulty
    return unless @difficulty.present?

    @spots = @spots.where(difficulty: @difficulty)
  end

  def filter_by_time
    return unless @time.present?

    case @time
    when "Today"
      @weathers = Weather.where(time: [DateTime.now.beginning_of_day + 7.hour..DateTime.now.end_of_day - 2.hour])
    when "Tomorrow"
      @weathers = Weather.where(time: [DateTime.tomorrow.beginning_of_day + 7.hour..DateTime.tomorrow.end_of_day - 2.hour])
    when "After"
      @weathers = Weather.where(time: [2.days.from_now.beginning_of_day + 7.hour..2.days.from_now.end_of_day - 2.hour])
    end
  end

  def filter_by_wind
    return unless @wind_min.present? && @wind_max.present?

    @weathers = @weathers.where(wind_force: @wind_min..@wind_max)
  end

  def filter_by_address
    return unless @longitude.present? && @latitude.present?

    perimeter = @perimeter.present? ? @perimeter.to_i : 1000
    @spots = @spots.near([@latitude, @longitude], perimeter)
  end
end
