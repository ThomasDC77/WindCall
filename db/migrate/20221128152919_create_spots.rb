class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.text :description
      t.string :difficulty

      t.timestamps
    end
  end
end
