class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.float :wind_force
      t.float :wind_direction
      t.references :spot, null: false, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
