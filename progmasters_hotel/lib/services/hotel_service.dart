import 'dart:convert';

import 'package:http/http.dart';
import 'package:progmasters_hotel/dto/filters/init_filter.dart';
import 'package:progmasters_hotel/dto/hotel_list/hotel_list_model.dart';

import 'file:///C:/Flutter/applications/hotel/hotel-flutter/progmasters_hotel/lib/dto/home/city_names.dart';

class HotelService {
  final String baseUrl = 'https://hotel.progmasters.hu/api/hotels';

  List<String> cityNames = [];

  static HotelListModel hotelListModel;

  static InitFilter filter;

  InitFilter initFilter = new InitFilter(null, null, null, null);

  Future<HotelListModel> getHotelListModel(InitFilter filter) async {
    try {
      // String token = '';
      Response response =
          await post('https://hotel.progmasters.hu/api/reservation/initFilter',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'currentDate': filter.currentDate,
                'startReservation': filter.startReservation,
                'endReservation': filter.endReservation,
                'town': filter.town,
              }));
      if (response.statusCode == 200) {
        hotelListModel = HotelListModel.fromJson(jsonDecode(response.body));
        return hotelListModel;
      }
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
