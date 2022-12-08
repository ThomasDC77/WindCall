class AlertsController < ApplicationController
  def new
    @alert = Alert.new
  end

  def create
    @alert = Alert.new(alert_params)
    return unless @alert.save!

    SendAlertJob.new(@alert.id, "welcome").perform_now
    redirect_back(fallback_location: spots_path)
    # on crée une seule alerte avec les params récupérer via le formulaire de l'index et si on arrive a save on redirige vers la même page (redirect_back) pour conserver les params rentrés dans la page homes pour la liste d'index
  end

  private

  def alert_params
    params.require(:alert).permit(:difficulty, :wind_min, :wind_max, :time, :address, :perimeter, :telephone_number)
  end
end
