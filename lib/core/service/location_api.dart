import 'package:coffeefinder/core/model/location_data.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationApi {
  Location _location = Location();
  String? error;

  static LocationApi? _instance;
  static LocationApi getInstance() => _instance ??= LocationApi();

  Future<MyLocationData> getLocation() async {
    LocationData? location;

    try {
      location = await _location.getLocation();
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission Denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission Denied Never Ask';
      }
      location = null;
    }
    return MyLocationData.locationItems(location);
  }
}
