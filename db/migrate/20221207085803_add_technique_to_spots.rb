class AddTechniqueToSpots < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :technique, :text
  end
end
