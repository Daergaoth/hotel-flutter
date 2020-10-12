import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:progmasters_hotel/dto/filters/hotel_filter_model.dart';
import 'package:progmasters_hotel/dto/filters/init_filter.dart';
import 'package:progmasters_hotel/services/hotel_service.dart';

import 'loading_dialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map cityNames;
  DateTime _datePickerStartMax;
  DateTime _currentDate;
  DateTime _start;
  DateTime _end;
  DateTime _endMinValue;
  List<String> _suggestions;
  String _selectedCity;
  AutoCompleteTextField _searchField;
  GlobalKey<AutoCompleteTextFieldState<String>> key;
  String _pickedStartDate;
  String _pickedEndDate;
  String _currentDateString;
  bool _isDateInvalid;
  bool _isCityNameInvalid;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  initState() {
    super.initState();
    _currentDate = DateTime.now();
    _datePickerStartMax =
        DateTime((_currentDate.year + 1), _currentDate.month, _currentDate.day);
    key = new GlobalKey();
    _start = DateTime(_currentDate.year, _currentDate.month, _currentDate.day);
    _currentDateString =
        '${_currentDate.year}-${_currentDate.month}-${_currentDate.day - 1}';
    _pickedStartDate = '${_start.year}-${_start.month}-${_start.day}';
    _end = setupEndDate(_start);
    _pickedEndDate = '${_end.year}-${_end.month}-${_end.day}';
    _isDateInvalid = false;
    _isCityNameInvalid = false;
    _endMinValue = _end;
  }

  @override
  Widget build(BuildContext context) {
    cityNames = ModalRoute.of(context).settings.arguments;
    _suggestions = cityNames['cityNames'];

    _searchField = AutoCompleteTextField(
        decoration: InputDecoration(
          // errorText: 'Field is mandatory',
            contentPadding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
            hintText: "Enter city you want to visit",
            hintStyle: TextStyle(color: Colors.lightBlue[900])),
        itemSubmitted: (item) {
          setState(() {
            _searchField.textField.controller.text = item;
          });
        },
        key: key,
        textChanged: (text) {
          _selectedCity = text;
          validateCityName();
        },
        textSubmitted: (text) {},
        clearOnSubmit: false,
        submitOnSuggestionTap: false,
        suggestions: _suggestions,
        itemBuilder: (context, item) {
          return Text(
            item,
            style: TextStyle(color: Colors.lightBlue[900], fontSize: 30.0),
          );
        },
        itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemFilter: (item, query) {
          return item.toLowerCase().startsWith(query.toLowerCase());
        });

    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Progmasters Hotel'),
            centerTitle: true,
            backgroundColor: Colors.lightBlue[900],
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: _searchField,
              ),
              Text(
                _isCityNameInvalid ? 'City name is mandatory' : '',
                style: TextStyle(
                  color: Colors.red[700],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('From: $_pickedStartDate',
                      style: TextStyle(color: Colors.lightBlue[900]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          icon: Icon(Icons.calendar_today,
                            color: _isDateInvalid ? Colors.red[700] : Colors
                                .lightBlue[900],),
                          onPressed: () {
                            showDatePicker(
                                context: context,
                                initialDate: _start,
                                firstDate: _currentDate,
                                lastDate: _datePickerStartMax)
                                .then((date) {
                              setState(() {
                                if (date != null) {
                                  _start = date;
                                  _pickedStartDate =
                                  '${_start.year}-${_start.month}-${_start
                                      .day}';
                                  validateDate();
                                  if (!_isDateInvalid) {
                                    _endMinValue = setupEndDate(_start);
                                  }
                                }
                              });
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Till: $_pickedEndDate',
                        style: TextStyle(color: Colors.lightBlue[900]),),
                    ),
                    IconButton(
                        icon: Icon(Icons.calendar_today,
                          color: _isDateInvalid ? Colors.red[700] : Colors
                              .lightBlue[900],),
                        // child: Text('Select a end date.'),
                        onPressed: () {
                          showDatePicker(
                              context: context,
                              initialDate: _end,
                              firstDate: _endMinValue,
                              lastDate: _datePickerStartMax)
                              .then((date) {
                            setState(() {
                              if (date != null) {
                                _end = date;
                                _pickedEndDate =
                                '${_end.year}-${_end.month}-${_end.day}';
                                validateDate();
                              }
                            });
                          });
                        }),
                  ],
                ),
              ),
              Text(
                _isDateInvalid
                    ? 'Date is invalid, please check it. \nMax reservation duration is 28 days.'
                    : '',
                style: TextStyle(
                  color: Colors.red[700],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                child: Builder(
                  builder: (context) =>
                      RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              5.0, 5.0, 10.0, 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.search, color: Colors.white,),
                              SizedBox(width: 10.0,),
                              Text('Search', style: TextStyle(
                                  color: Colors.white),),

                            ],
                          ),
                        ),
                        onPressed: () {
                          validateCityName();
                          validateDate();

                          if (_isDateInvalid || _isCityNameInvalid) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Row(
                                      children: [
                                        Icon(Icons.mood_bad,
                                          color: Colors.red[700],),
                                        SizedBox(width: 10.0,),
                                        Text(
                                  'Please fill all field with valid information.',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                  ),
                                ),
                              ],
                            )));
                      } else {
                        HotelService.hotelFilterModel = new HotelFilterModel();
                        HotelService.hotelFilterModel.town = _selectedCity;
                        HotelService.hotelFilterModel.currentDate =
                            _currentDateString;
                        HotelService.hotelFilterModel.startReservation =
                            _pickedStartDate;
                        HotelService.hotelFilterModel.endReservation =
                            _pickedEndDate;
                        // HotelService.filter = new InitFilter(
                        //     _currentDateString, _pickedStartDate,
                        //     _pickedEndDate, _selectedCity);
                        Navigator.pushNamed(context, '/hotel-list');
                      }
                    },
                    color: Colors.lightBlue[900],
                  ),
                ),
              ),
            ],
          )),
    );
    //throw UnimplementedError();
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      HotelService hotelService = new HotelService();
      Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
      await hotelService.getHotelListModel(new InitFilter(
          _currentDateString, _pickedStartDate, _pickedEndDate, _selectedCity));
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge
      Navigator.pushReplacementNamed(context, "/hotel-list");
    } catch (error) {
      print(error);
    }
  }

  void validateDate() {
    int difference = _end
        .difference(_start)
        .inDays;
    if (difference < 1 || difference > 28) {
      _isDateInvalid = true;
    } else {
      _isDateInvalid = false;
    }
  }

  DateTime setupEndDate(DateTime start) {
    int startYear = start.year;
    int startMonth = start.month;
    int startDay = start.day;

    DateTime endToReturn;

    if ((startMonth == 1 ||
        startMonth == 3 ||
        startMonth == 5 ||
        startMonth == 7 ||
        startMonth == 8 ||
        startMonth == 10) &&
        startDay == 31) {
      endToReturn = DateTime(startYear, startMonth + 1, 1);
    } else if (startMonth == 12 && startDay == 31) {
      endToReturn = DateTime(startYear + 1, 1, 1);
    } else if ((startMonth == 4 ||
        startMonth == 6 ||
        startMonth == 9 ||
        startMonth == 11) &&
        startDay == 30) {
      endToReturn = DateTime(startYear, startMonth + 1, 1);
    } else if (startYear % 4 == 0 && startMonth == 2 && startDay == 29) {
      endToReturn = DateTime(startYear, startMonth + 1, 1);
    } else if (startYear % 4 != 0 && startMonth == 2 && startDay == 28) {
      endToReturn = DateTime(startYear, startMonth + 1, 1);
    } else {
      endToReturn = DateTime(startYear, startMonth, startDay + 1);
    }

    return endToReturn;
  }

  void validateCityName() {
    if (_selectedCity == null || _selectedCity == '') {
      _isCityNameInvalid = true;
    } else {
      _isCityNameInvalid = false;
    }
  }
}
