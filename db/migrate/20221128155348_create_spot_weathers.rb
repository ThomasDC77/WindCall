class CreateSpotWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :spot_weathers do |t|
      t.datetime :time
      t.references :spot, null: false, foreign_key: true
      t.references :weather, null: false, foreign_key: true

      t.timestamps
    end
  end
end
