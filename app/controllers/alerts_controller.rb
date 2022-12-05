class AlertsController < ApplicationController
  def create
    @alert = Alert.new(alert_params)
    if @alert.save!
      redirect_back(fallback_location: spots_path)
    end
    # on crée une seule alerte avec les params récupérer via le formulaire de l'index et si on arrive a save on redirige vers la même page (redirect_back) pour conserver les params rentrés dans la page homes pour la liste d'index
  end

  private

  def alert_params
    params.require(:alert).permit(:difficulty, :wind_min, :wind_max, :time, :address, :perimeter, :telephone_number)
  end
end
