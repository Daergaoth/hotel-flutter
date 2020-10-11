import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map cityNames;

  // Widget row(String cityName){
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Text(cityName,
  //       style: TextStyle(
  //         color: Colors.lightBlue[900],
  //         fontSize: 20.0
  //       ),
  //       ),
  //       SizedBox(
  //         width: 10.0,
  //       )
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    cityNames = ModalRoute.of(context).settings.arguments;
    List<String> suggestions = cityNames['cityNames'];
    print(cityNames);
    String selectedCity;

    AutoCompleteTextField searchField;
    GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

    searchField = AutoCompleteTextField(
        decoration: InputDecoration(
            // errorText: 'Field is mandatory',
            contentPadding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
            hintText: "Enter city you want to visit"),
        itemSubmitted: (item) {
          setState(() {
            searchField.textField.controller.text = item;
          });
        },
        key: key,
        textChanged: (text) {
          selectedCity = text;
        },
        textSubmitted: (text) {},
        clearOnSubmit: false,
        submitOnSuggestionTap: false,
        suggestions: suggestions,
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
            searchField,
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 12.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print(selectedCity);
                },
                color: Colors.lightBlue[900],
                iconSize: 36.0,
              ),
            ),
          ],
        ));
    //throw UnimplementedError();
  }
}
