class RemoveTemperatureFromWeathers < ActiveRecord::Migration[7.0]
  def change
    remove_column :weathers, :temperature
  end
end
