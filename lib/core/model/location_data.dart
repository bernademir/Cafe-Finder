import 'package:location/location.dart';

class MyLocationData {
  final lat, lon;

  MyLocationData(this.lat, this.lon);

  static MyLocationData locationItems(LocationData? location) {
    double? lat = location!.latitude;
    double? lon = location.longitude;
    return MyLocationData(lat, lon);
  }
}
