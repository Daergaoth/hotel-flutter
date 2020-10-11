import 'package:progmasters_hotel/dto/currency_model/currency_dto_model.dart';
import 'package:progmasters_hotel/dto/enum_models/hotel_features_option.dart';
import 'package:progmasters_hotel/dto/hotel_list/hotel_item_model.dart';

class HotelListModel {
  List<HotelItemModel> hotels;
  List<HotelFeaturesOption> hotelFeaturesOptions;
  List<CurrencyDTOModel> currencyOptions;
  List<String> hotelNameList;

  HotelListModel(
      {this.hotels,
      this.hotelFeaturesOptions,
      this.currencyOptions,
      this.hotelNameList});

  factory HotelListModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> hotelsJSON = json['hotels'];
    List<dynamic> hotelFeaturesOptionsJSON = json['hotelFeaturesOptions'];
    List<dynamic> currencyOptionsJSON = json['currencyOptions'];
    List<HotelItemModel> hotels = [];
    List<HotelFeaturesOption> hotelFeaturesOptions = [];
    List<CurrencyDTOModel> currencyOptions = [];

    for (int i = 0; i < hotelsJSON.length; i++) {
      hotels.add(HotelItemModel.fromJson(hotelsJSON[i]));
    }

    for (int i = 0; i < hotelFeaturesOptionsJSON.length; i++) {
      hotelFeaturesOptions
          .add(HotelFeaturesOption.fromJson(hotelFeaturesOptionsJSON[i]));
    }

    for (int i = 0; i < currencyOptionsJSON.length; i++) {
      currencyOptions.add(CurrencyDTOModel.fromJson(currencyOptionsJSON[i]));
    }

    return HotelListModel(
      hotels: hotels,
      hotelFeaturesOptions: hotelFeaturesOptions,
      currencyOptions: currencyOptions,
      hotelNameList: json['hotelNameList'],
    );
  }
}
