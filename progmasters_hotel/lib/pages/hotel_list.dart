import 'package:flutter/material.dart';
import 'package:progmasters_hotel/dto/currency_model/currency_model.dart';
import 'package:progmasters_hotel/dto/enum_models/hotel_features_option.dart';
import 'package:progmasters_hotel/dto/hotel_list/hotel_item_model.dart';
import 'package:progmasters_hotel/dto/hotel_list/hotel_list_model.dart';
import 'package:progmasters_hotel/dto/image/image_saved.dart';

class HotelList extends StatefulWidget {
  @override
  _HotelListState createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  List<HotelItemModel> hotels = [];
  HotelListModel hotelList = new HotelListModel();

  @override
  void initState() {
    ImageSaved imageSaved = new ImageSaved(
        id: 1,
        imgUrl:
            "http://res.cloudinary.com/daergaoth/image/upload/v1600980695/vesmak9jsxnmwisnljcy.png",
        imageStatus: "ACTIVE");
    List<HotelFeaturesOption> features = [];
    features.add(new HotelFeaturesOption(
        name: "BABY_FRIENDLY", displayName: "baby friendly"));

    HotelItemModel hotel = new HotelItemModel(
        id: 1,
        name: 'Sajt',
        mainImageUrl: imageSaved,
        town: "Budapest",
        roomNumber: 6,
        numberOfBeds: 12,
        userRating: 4.2,
        avgRoomCost: 62.54,
        ratingGiven: 2,
        distanceFromCenter: 2.1,
        description: ("Budapest belvárosában, a világörökség részét képező Andrássy úttal párhuzamosan fekvő Benczúr utcában, könnyen megközelíthető helyen, mégis a város zajától elzárva, elegáns környezetben található a Benczúr Hotel. Szállodánk teraszai, hangulatos, árnyas belső kertje tavasztól őszig egyedülálló lehetőséget nyújtanak különleges hangulatú fogadások, kerti partik, szabadtéri rendezvények lebonyolításához." +
            "Szállodánk 90 standard (3-csillagos színvonalú) és 58 superior (4-csillagos színvonalú) szobával, 4 superior apartmannal és 8 lakosztállyal várja vendégeit. Az igényesen kialakított szobák színes televízióval, telefonnal és minibárral, Internet kapcsolattal felszereltek, a superior kategóriában teljesen, a standard kategóriában részben légkondicionáltak. Superior szárnyunk teljes egészében nem dohányzó, itt kialakításra kerültek mozgáskorlátozottak részére alkalmas, valamint anti-allergén szobák is." +
            "A vendégek további kényelmét szobaszerviz, széf, csomagmegőrző, őrzött parkoló, mosoda szolgálja, kikapcsolódását étterem, kávézó, internet sarok és hangulatos kerthelyiség biztosítja. Szállodánk recepciója teljes körű programszervezéssel segíti vendégeit szabadidejének tartalmas eltöltésében." +
            "Szállodánk hét különböző méretű konferenciateremmel és egy a'la carte étteremmel rendelkezik, melyek mindegyike légkondicionált, a legkorszerűbb technikával felszerelt és minden igényt kielégítően, változatosan berendezhető. A legnagyobb 250, a legkisebb helyiségünk pedig 20 fő befogadására képes."),
        reservedRooms: 2,
        hotelFeatures: features,
        latitude: 47.19,
        longitude: 19.47,
        currency: new CurrencyModel(name: "EUR", displayName: "euro"));

    hotels.add(hotel);
    hotels.add(hotel);
    hotelList.hotels = hotels;
  }

  _HotelListState() {}

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: ListView.builder(
          itemCount: hotelList.hotels.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {},
                  title: Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            hotelList.hotels[index].name,
                            style: TextStyle(
                                color: Colors.lightBlue[900], fontSize: 20.0),
                          ),
                          Row(
                            children: [
                              Text(
                                'User rating: ',
                                style: TextStyle(
                                  color: Colors.lightBlue[900],
                                ),
                              ),
                              Text(
                                '★',
                                style: TextStyle(
                                  color: hotelList.hotels[index].userRating >= 1
                                      ? Colors.amber
                                      : Colors.grey[200],
                                ),
                              ),
                              Text(
                                '★',
                                style: TextStyle(
                                  color: hotelList.hotels[index].userRating >= 2
                                      ? Colors.amber
                                      : Colors.grey[200],
                                ),
                              ),
                              Text(
                                '★',
                                style: TextStyle(
                                  color: hotelList.hotels[index].userRating >= 3
                                      ? Colors.amber
                                      : Colors.grey[200],
                                ),
                              ),
                              Text(
                                '★',
                                style: TextStyle(
                                  color: hotelList.hotels[index].userRating >= 4
                                      ? Colors.amber
                                      : Colors.grey[200],
                                ),
                              ),
                              Text(
                                '★',
                                style: TextStyle(
                                  color: hotelList.hotels[index].userRating >= 5
                                      ? Colors.amber
                                      : Colors.grey[200],
                                ),
                              ),
                              Text(
                                '(${hotelList.hotels[index].ratingGiven})',
                                style: TextStyle(
                                  color: Colors.lightBlue[900],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Average prices: ${hotelList.hotels[index].avgRoomCost.toString()} EUR',
                            style: TextStyle(
                              color: Colors.lightBlue[900],
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Current free rooms: ${(hotelList.hotels[index].roomNumber - hotelList.hotels[index].reservedRooms)}',
                            style: TextStyle(
                              color: Colors.lightBlue[900],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  leading: Image(
                      image: NetworkImage(
                          '${hotelList.hotels[index].mainImageUrl.imgUrl}')),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// class HotelListWidget extends StatefulWidget{
//   @override
//   _HotelListWidgetState createState() => _HotelListWidgetState();
//
// }
//
// class _HotelListWidgetState extends State<HotelListWidget>{
//   @override
//   Widget build(BuildContext context) {
//     return
//     // throw UnimplementedError();
//   }
//
// }
