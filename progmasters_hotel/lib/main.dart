import 'package:flutter/material.dart';
import 'package:progmasters_hotel/pages/home_page.dart';
import 'package:progmasters_hotel/pages/hotel_list.dart';
import 'package:progmasters_hotel/pages/loading_home.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/hotel-list': (context) => HotelList(),
    },
  ));
}
