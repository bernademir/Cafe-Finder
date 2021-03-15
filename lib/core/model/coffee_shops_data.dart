import 'package:coffeefinder/core/model/shops.dart';
import 'package:google_maps_webservice/places.dart';

class CoffeeShopsData {
  List<Shops>? shopList;
  CoffeeShopsData(this.shopList);

  static convertToShops(List<PlacesSearchResult> googlePlaces) {
    List<Shops> shops = [];

    googlePlaces.forEach((shop) {
      shops.add(Shops.shopDetails(shop));
    });
    return CoffeeShopsData(shops);
  }
}
