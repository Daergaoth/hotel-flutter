import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

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
  bool _isDateInvalid;
  bool _isCityNameInvalid;

  initState() {
    super.initState();
    _currentDate = DateTime.now();
    _datePickerStartMax =
        DateTime((_currentDate.year + 1), _currentDate.month, _currentDate.day);
    key = new GlobalKey();
    _start =
        DateTime(_currentDate.year, _currentDate.month, _currentDate.day, 2);
    _pickedStartDate = '${_start.year} - ${_start.month} - ${_start.day}';
    _end = setupEndDate(_start);
    _pickedEndDate = '${_end.year} - ${_end.month} - ${_end.day}';
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
            hintText: "Enter city you want to visit"),
        itemSubmitted: (item) {
          setState(() {
            _searchField.textField.controller.text = item;
          });
        },
        key: key,
        textChanged: (text) {
          _selectedCity = text;
          validateCityName(text);
        },
        textSubmitted: (text) {},
        clearOnSubmit: false,
        submitOnSuggestionTap: false,
        suggestions: _suggestions,
        itemBuilder: (context, item) {
          return Text(
            item,
            style: TextStyle(color: Colors.lightBlue[900], fontSize: 20.0),
          );
        },
        itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemFilter: (item, query) {
          return item.toLowerCase().startsWith(query.toLowerCase());
        });

    return Scaffold(
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
                  Text('From: $_pickedStartDate'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(Icons.calendar_today),
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
                                '${_start.year} - ${_start.month} - ${_start
                                    .day}';
                                validateStartDate();
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
                    child: Text('Till: $_pickedEndDate'),
                  ),
                  IconButton(
                      icon: Icon(Icons.calendar_today),
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
                              '${_end.year} - ${_end.month} - ${_end.day}';
                              validateStartDate();
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
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print(_selectedCity);
                },
                color: Colors.lightBlue[900],
                iconSize: 36.0,
              ),
            ),
          ],
        ));
    //throw UnimplementedError();
  }

  void validateStartDate() {
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

  void validateCityName(String text) {
    if (text == null) {
      _isCityNameInvalid = true;
    } else {
      _isCityNameInvalid = false;
    }
  }
}
