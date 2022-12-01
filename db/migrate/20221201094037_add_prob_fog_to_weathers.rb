class AddProbFogToWeathers < ActiveRecord::Migration[7.0]
  def change
    add_column :weathers, :prob_fog, :integer
  end
end
