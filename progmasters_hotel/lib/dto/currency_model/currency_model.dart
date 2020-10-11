class CurrencyModel {
  String name;
  String displayName;

  CurrencyModel({this.name, this.displayName});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      name: json['name'],
      displayName: json['displayName'],
    );
  }
}
