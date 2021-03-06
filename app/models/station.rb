class Station < ApplicationRecord
  has_many :ride_stations
  has_many :rides, through: :ride_stations
  
  def coordinates
    Geocoder.coordinates(address)
  end
end
