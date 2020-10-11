class CurrencyDTOModel {
  String name;
  String displayName;
  double currentExchange;

  CurrencyDTOModel({this.name, this.displayName, this.currentExchange});

  factory CurrencyDTOModel.fromJson(Map<String, dynamic> json) {
    return CurrencyDTOModel(
        name: json['name'],
        displayName: json['displayName'],
        currentExchange: json['currentExchange']);
  }
}
