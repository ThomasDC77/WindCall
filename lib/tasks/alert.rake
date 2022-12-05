namespace :alert do
  task send: :environment do
    Alert.all.each do |alert|
      filtered_spots = FilterSpotsService.new(alert.difficulty, alert.wind_min, alert.wind_max, alert.time, alert.address, alert.perimeter).call
      if filtered_spots.any?
        ## send message
      end
    end
  end
end
