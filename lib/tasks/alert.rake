namespace :alert do
  task send: :environment do
    Alert.all.each do |alert|
      filtered_spots = FilterSpotsService.new(alert.difficulty, alert.wind_min, alert.wind_max, alert.time, alert.address, alert.perimeter).call
      if filtered_spots.any?
        ## send message
      end
      # on crée une task send dans un environnement, pour toutes les alertes on instancie une variable filtered_spots qui prend tous les spots qui répondent au critères saisis.
    end
  end
end
