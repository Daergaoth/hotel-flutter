class HotelFeaturesOption {
  String name;
  String displayName;

  HotelFeaturesOption({this.name, this.displayName});

  factory HotelFeaturesOption.fromJson(Map<String, dynamic> json) {
    return HotelFeaturesOption(
      name: json['name'],
      displayName: json['displayName'],
    );
  }
}
