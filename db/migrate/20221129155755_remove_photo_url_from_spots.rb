class RemovePhotoUrlFromSpots < ActiveRecord::Migration[7.0]
  def change
    remove_column :spots, :photo_url
  end
end
