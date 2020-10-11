class CityNames {
  final List<dynamic> cityNames;

  CityNames({this.cityNames});

  factory CityNames.fromJson(Map<String, dynamic> json) {
    return CityNames(
      cityNames: json['cityNames'],
    );
  }
}
