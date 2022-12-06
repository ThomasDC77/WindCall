class AddCriteriaToSpots < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :criteria, :string
  end
end
