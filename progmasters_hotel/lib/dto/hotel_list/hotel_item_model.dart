import 'package:progmasters_hotel/dto/currency_model/currency_model.dart';
import 'package:progmasters_hotel/dto/enum_models/hotel_features_option.dart';
import 'package:progmasters_hotel/dto/image/image_saved.dart';

class HotelItemModel {
  int id;
  String name;
  ImageSaved mainImageUrl;
  String town;
  int roomNumber;
  int numberOfBeds;
  double userRating;
  double avgRoomCost;
  int ratingGiven;
  double distanceFromCenter;
  String description;
  int reservedRooms;
  List<HotelFeaturesOption> hotelFeatures;
  double latitude;
  double longitude;
  CurrencyModel currency;

  HotelItemModel(
      {this.id,
      this.name,
      this.mainImageUrl,
      this.town,
      this.roomNumber,
      this.numberOfBeds,
      this.userRating,
      this.avgRoomCost,
      this.ratingGiven,
      this.distanceFromCenter,
      this.description,
      this.reservedRooms,
      this.hotelFeatures,
      this.latitude,
      this.longitude,
      this.currency});

  factory HotelItemModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> featuresJSON = json['hotelFeatures'];
    List<HotelFeaturesOption> features = [];
    for (int i = 0; i < featuresJSON.length; i++) {
      features.add(HotelFeaturesOption.fromJson(featuresJSON[i]));
    }
    return HotelItemModel(
        name: json['name'],
        id: json['id'],
        mainImageUrl: ImageSaved.fromJson(json['mainImageUrl']),
        town: json['town'],
        roomNumber: json['roomNumber'],
        numberOfBeds: json['numberOfBeds'],
        userRating: json['userRating'],
        avgRoomCost: json['avgRoomCost'],
        ratingGiven: json['ratingGiven'],
        distanceFromCenter: json['distanceFromCenter'],
        description: json['description'],
        reservedRooms: json['reservedRooms'],
        hotelFeatures: features,
        latitude: json['latitude'],
        longitude: json['longitude'],
        currency: CurrencyModel.fromJson(json['currency']));
  }
}
