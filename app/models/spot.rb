class Spot < ApplicationRecord
  has_many :weathers, dependent: :destroy
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  before_destroy :destroy_photos

  def distance_between(address_lat, address_long)
    Geocoder::Calculations.distance_between([address_lat, address_long], [latitude, longitude]).round(0)
  end

  def weathers_filtered_by_time(weather_ids_only_time)
    weathers.where(id: weather_ids_only_time)
  end

  private

  def geocode
    # Initially just call the original method as intended.
    super

    # Check to see if geocoding failed.
    return unless latitude.blank? && longitude.blank?

    postal_code = address.scan(/\d{5}/).first
    geocode = Geocoder.search(postal_code).find { |r| r.data["address"]["country_code"] == "fr" }
    self.longitude = geocode.coordinates[1] if geocode
    self.latitude = geocode.coordinates[0] if geocode
  end

  def destroy_photos
    photos.purge
  end
end
