import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:progmasters_hotel/dto/filters/init_filter.dart';

import 'file:///C:/Flutter/applications/hotel/hotel-flutter/progmasters_hotel/lib/dto/home/city_names.dart';
import 'file:///C:/Flutter/applications/hotel/hotel-flutter/progmasters_hotel/lib/dto/hotel_list/hotel_list_model.dart';

class HotelService {
  final String baseUrl = 'https://hotel.progmasters.hu/api/hotels';

  List<String> cityNames = [];

  HotelListModel hotelListModel;

  Future<void> getHotelListModel(InitFilter filter) async {
    try {
      String token = '';
      Response response = await post('$baseUrl/',
          body: filter,
          headers: {HttpHeaders.proxyAuthenticateHeader: 'Bearer$token'});
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCityNames() async {
    try {
      Response response = await get(baseUrl + '/towns');
      if (response.statusCode == 200) {
        CityNames cityNames = CityNames.fromJson(jsonDecode(response.body));
        for (int i = 0; i < cityNames.cityNames.length; i++) {
          this.cityNames.add(cityNames.cityNames[i].toString());
        }
      } else {
        throw Exception('Error occurred!');
      }
    } catch (e) {
      print(e);
    }
  }
}
