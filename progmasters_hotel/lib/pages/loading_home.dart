import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progmasters_hotel/services/hotel_service.dart' as hotelService;

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<String> cityNames = [];

  @override
  void initState() {
    super.initState();
    getCityNames();
  }

  void getCityNames() async {
    hotelService.HotelService service = new hotelService.HotelService();
    await service.getCityNames();
    this.cityNames = service.cityNames;
    Navigator.pushReplacementNamed(context, '/home',
        arguments: {'cityNames': cityNames});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.lightBlue[900],
          size: 50.0,
        ),
      ),
    );
  }
}
