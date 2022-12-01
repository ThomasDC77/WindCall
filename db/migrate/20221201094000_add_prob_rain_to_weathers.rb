class AddProbRainToWeathers < ActiveRecord::Migration[7.0]
  def change
    add_column :weathers, :prob_rain, :integer
  end
end
