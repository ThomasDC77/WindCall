class Spot < ApplicationRecord
  has_many :spot_weathers
  has_many :weathers, through: :spot_weathers
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  private

  def geocode
    # Initially just call the original method as intended.
    super

    # Check to see if geocoding failed.
    if latitude.blank? && longitude.blank?
      postal_code = self.address.scan(/\d+/).first
      geocode = Geocoder.search(postal_code)
      self.longitude = geocode.first.coordinates[1] if geocode.first&.coordinates
      self.latitude = geocode.first.coordinates[0] if geocode.first&.coordinates
    end
  end
end
