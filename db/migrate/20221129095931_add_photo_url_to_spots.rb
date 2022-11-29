class AddPhotoUrlToSpots < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :photo_url, :string
  end
end
