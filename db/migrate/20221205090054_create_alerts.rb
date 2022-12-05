class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.string :telephone_number
      t.string :difficulty
      t.integer :wind_min
      t.integer :wind_max
      t.datetime :time
      t.string :address
      t.integer :perimeter

      t.timestamps
    end
  end
end
