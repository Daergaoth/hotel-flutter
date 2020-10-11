class InitFilter {
  String currentDate;
  String startReservation;
  String endReservation;
  String town;

  InitFilter.name(
      {this.currentDate,
      this.startReservation,
      this.endReservation,
      this.town});

  InitFilter(String currentDate, String startReservation, String endReservation,
      String town) {
    this.currentDate = currentDate;
    this.startReservation = startReservation;
    this.endReservation = endReservation;
    this.town = town;
  }

  factory InitFilter.fromJson(Map<String, dynamic> json) {
    return InitFilter(
      json['currentDate'],
      json['startReservation'],
      json['endReservation'],
      json['town'],
    );
  }
}
