import 'package:coffeefinder/ui/view/map_page_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shops',
      debugShowCheckedModeBanner: false,
      home: MapPageView(),
    );
  }
}
