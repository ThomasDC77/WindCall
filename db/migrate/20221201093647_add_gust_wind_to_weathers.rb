class AddGustWindToWeathers < ActiveRecord::Migration[7.0]
  def change
    add_column :weathers, :gust_wind, :integer
  end
end
