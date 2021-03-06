# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Ride.create(name: "Two Wheel Tuesday", date_time: Time.new(2020, 2, 15, 17), starting_point: "630 N. Kingsley Dr. Los Angeles, CA 90004", starting_point_lat: 34.082590, starting_point_long: -118.303240, end_point: "1000 Vin Scully Ave, Los Angeles, CA 90012", end_point_lat: 34.072578, end_point_long: -118.240288, ride_distance: 7.5, bike_type: "any")
# Ride.create(name: "Canyon Run", date_time: Time.new(2020, 2, 15, 10), starting_point: "630 N. Kingsley Dr. Los Angeles, CA 90004", starting_point_lat: 34.082590, starting_point_long: -118.303240, end_point: "8401 Mulholland Dr, Studio City, CA 91604", end_point_lat: 34.122580, end_point_long: -118.387090, ride_distance: 8.7, bike_type: "sport")
# Ride.create(name: "Super Sunday", date_time: Time.new(2020, 5, 24, 9), starting_point: "5505 Rosemead Blvd. Temple City, CA 91780", starting_point_lat: 34.09925, starting_point_long: -118.07387, end_point: "24606 Santa Clara Ave, Dana Point, CA 92629", end_point_lat: 33.46387, end_point_long: -117.70162, ride_distance: 60.7, bike_type: "any")


page = Nokogiri::HTML(RestClient.get("https://www.pure-gas.org/index.jsp?stateprov=CA"))
stations = page.css('.stationList', 'tr')
i = 6
while i <= 28
  name = stations[i].elements[4].text
  station_address = stations[i].elements[6].text
  city = stations[i].elements[1].text
  brand = stations[i].elements[2].text
  octane = stations[i].elements[3].text
  phone = stations[i].elements[5].text
  state = "CA"
  url = "http://www.mapquestapi.com/geocoding/v1/address?key=MAPQUESTKEYHERE!!!&street=#{station_address}&city=#{city}&state=#{state}"
  response = HTTParty.get(url)
  lat = response['results'][0]['locations'][0]['latLng']['lat']
  lng = response['results'][0]['locations'][0]['latLng']['lng']
  station = Station.create(name: name, street_address: station_address, city: city, latitude: lat, longitude: lng, brand: brand, octane: octane, phone_number: phone, state: state)
  i += 1
end

