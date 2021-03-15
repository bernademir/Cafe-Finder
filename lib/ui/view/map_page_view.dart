import 'package:coffeefinder/core/model/coffee_shops_data.dart';
import 'package:coffeefinder/core/model/location_data.dart';
import 'package:coffeefinder/core/service/coffee_shops_api.dart';
import 'package:coffeefinder/core/service/location_api.dart';
import 'package:coffeefinder/ui/widget/coffee_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageView extends StatefulWidget {
  @override
  _MapPageViewState createState() => _MapPageViewState();
}

class _MapPageViewState extends State<MapPageView> {
  GoogleMapController? mapController;
  MyLocationData? _myLocationData;
  CoffeeShopsData? _shops;
  String? _shopName;
  String? _shopImage;

  List<Marker> allMarkers = [];

  Future<CoffeeShopsData> _getCoffeeShops() async {
    final shopsApi = CoffeeShopsApi.getInstance();
    return await shopsApi.getCoffeeShops(this._myLocationData!);
  }

  Future<MyLocationData> _getLocation() async {
    final locationApi = LocationApi.getInstance();
    return await locationApi.getLocation();
  }

  void _addMarkers(CoffeeShopsData places) {
    places.shopList!.forEach((shop) {
      print(places.shopList);
      allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        position: LatLng(shop.lat, shop.lon),
        infoWindow: InfoWindow(title: shop.name, snippet: ''),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocation().then((location) {
      setState(() {
        _myLocationData = location;
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    _shops = await _getCoffeeShops();
    setState(() {
      mapController = controller;
      _addMarkers(_shops!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coffee Shops"),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: _myLocationData != null
                ? SizedBox(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              _myLocationData!.lat, _myLocationData!.lon),
                          zoom: 12.0),
                      onMapCreated: _onMapCreated,
                      markers: Set.from(allMarkers),
                    ),
                  )
                : CircularProgressIndicator(
                    strokeWidth: 4.0,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
          ),
          Align(
            child: CoffeeCard(
              shopImage: _shopImage,
              shopName: _shopName,
            ),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
