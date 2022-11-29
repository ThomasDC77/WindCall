class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.float :wind_force
      t.float :wind_direction
      t.datetime :time

      t.timestamps
    end
  end
end
