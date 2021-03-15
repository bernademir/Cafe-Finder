import 'package:coffeefinder/core/config/config.dart';
import 'package:coffeefinder/core/model/coffee_shops_data.dart';
import 'package:coffeefinder/core/model/location_data.dart';
import 'package:google_maps_webservice/places.dart';

class CoffeeShopsApi {
  static CoffeeShopsApi? _instance;
  static CoffeeShopsApi getInstance() => _instance ??= CoffeeShopsApi();

  Future<CoffeeShopsData> getCoffeeShops(MyLocationData location) async {
    final googlePlaces = GoogleMapsPlaces(apiKey: apiKey);
    final response = await googlePlaces.searchNearbyWithRadius(
        Location(lat: location.lat, lng: location.lon), 200,
        type: 'cafe', keyword: 'coffee');
    return CoffeeShopsData.convertToShops(response.results);
  }
}
