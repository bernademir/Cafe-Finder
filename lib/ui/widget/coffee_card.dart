import 'package:coffeefinder/core/config/config.dart';
import 'package:flutter/material.dart';

class CoffeeCard extends StatelessWidget {
  final String? shopImage;
  final String? shopName;
  static const _endpoint = 'https://maps.googleapis.com/maps/api/place/photo';

  const CoffeeCard({Key? key, this.shopImage, this.shopName}) : super(key: key);

  String _photoApi() {
    return _endpoint +
        '?maxheight=150&photoreference=' +
        shopImage! +
        '&key=' +
        apiKey;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.0,
      width: 300.0,
      child: Card(
        child: Column(
          children: <Widget>[
            Image.network(
              _photoApi(),
              height: 150.0,
              width: 300.0,
              fit: BoxFit.cover,
            ),
            Text(shopName!),
          ],
        ),
      ),
    );
  }
}
