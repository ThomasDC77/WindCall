class FilterSpotsService

  def initialize(difficulty, wind_min, wind_max, time, address, perimeter)
    @spots = Spot.all
    @difficulty = difficulty
    @wind_min = wind_min
    @wind_max = wind_max
    @time = time
    @address = address
    @perimeter = perimeter
    @weathers = []
  end

  def call
    filter_by_difficulty
    filter_by_wind
    filter_by_time
    filter_by_address
    @weathers_ids = @weathers.map(&:id)
    @spots = @spots.joins(:weathers).where(weathers: { id: @weathers_ids })
    { spots: @spots.uniq, weathers: @weathers, weathers_ids: @weathers_ids }
  end

  def filter_by_difficulty
    return unless @difficulty.present?

    @spots = @spots.where(difficulty: @difficulty)
  end

  def filter_by_wind
    return unless @wind_min.present? && @wind_max.present?

    @weathers = Weather.where(wind_force: @wind_min..@wind_max)
  end

  def filter_by_time
    return unless @time.present?

    case @time
    when "today"
      @weathers = @weathers.where(time: [DateTime.now.beginning_of_day..DateTime.now.end_of_day])
    when "tomorrow"
      @weathers = @weathers.where(time: [DateTime.tomorrow.beginning_of_day..DateTime.tomorrow.end_of_day])
    when "after"
      @weathers = @weathers.where(time: [2.days.from_now.beginning_of_day..2.days.from_now.end_of_day])
    end
  end

  def filter_by_address
    return unless @address.present?

    geocode = Geocoder.search(@address).find { |r| r.data["address"]["country_code"] == "fr" }
    lat = geocode.coordinates[0]
    long = geocode.coordinates[1]
    perimeter = @perimeter.present? ? @perimeter.to_i : 1000
    @spots = @spots.near([lat, long], perimeter)
  end
end
