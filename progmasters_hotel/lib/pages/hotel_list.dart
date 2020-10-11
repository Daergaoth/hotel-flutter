import 'package:flutter/material.dart';
import 'package:progmasters_hotel/dto/hotel_list/hotel_item_model.dart';
import 'package:progmasters_hotel/dto/hotel_list/hotel_list_model.dart';
import 'package:progmasters_hotel/services/hotel_service.dart';

class HotelList extends StatefulWidget {
  @override
  _HotelListState createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  List<HotelItemModel> hotels = [];
  HotelListModel hotelList = new HotelListModel();

  // InitFilter filter;

  @override
  void initState() {
    super.initState();
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
        child: FutureBuilder<HotelListModel>(
          future: fetchHotelList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              hotelList = snapshot.data;
              return ListView.builder(
                itemCount: hotelList.hotels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 4.0),
                    child: Card(
                      child: ListTile(
                          onTap: () {},
                          title: Row(
                            children: <Widget>[
                              Column(
                                children: [
                                  Container(
                                    width: 230.0,
                                    child: Text(
                                      hotelList.hotels[index].name,
                                      style: TextStyle(
                                          color: Colors.lightBlue[900],
                                          fontSize: 20.0),
                                    ),
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
                                          color: hotelList.hotels[index]
                                                      .userRating >=
                                                  1
                                              ? Colors.amber
                                              : Colors.grey[200],
                                        ),
                                      ),
                                      Text(
                                        '★',
                                        style: TextStyle(
                                          color: hotelList.hotels[index]
                                                      .userRating >=
                                                  2
                                              ? Colors.amber
                                              : Colors.grey[200],
                                        ),
                                      ),
                                      Text(
                                        '★',
                                        style: TextStyle(
                                          color: hotelList.hotels[index]
                                                      .userRating >=
                                                  3
                                              ? Colors.amber
                                              : Colors.grey[200],
                                        ),
                                      ),
                                      Text(
                                        '★',
                                        style: TextStyle(
                                          color: hotelList.hotels[index]
                                                      .userRating >=
                                                  4
                                              ? Colors.amber
                                              : Colors.grey[200],
                                        ),
                                      ),
                                      Text(
                                        '★',
                                        style: TextStyle(
                                          color: hotelList.hotels[index]
                                                      .userRating >=
                                                  5
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
                                    hotelList.hotels[index].reservedRooms ==
                                            null
                                        ? 'Current free rooms: ${hotelList.hotels[index].roomNumber}'
                                        : 'Current free rooms: ' +
                                            (hotelList.hotels[index]
                                                        .roomNumber -
                                                    hotelList.hotels[index]
                                                        .reservedRooms)
                                                .toString(),
                                    // 'Current free rooms: ' + (hotelList.hotels[index].roomNumber - hotelList.hotels[index].reservedRooms).toString(),
                                    // 'Current free rooms: ${hotelList.hotels[index].reservedRooms}',
                                    style: TextStyle(
                                      color: Colors.lightBlue[900],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          leading: Container(
                            child: Image.network(
                              '${hotelList.hotels[index].mainImageUrl.imgUrl}',
                              fit: BoxFit.scaleDown,
                            ),
                            width: 50.0,
                            height: 50.0,
                          )),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<HotelListModel> fetchHotelList() async {
    HotelService hotelService = new HotelService();
    Future<HotelListModel> hotelListTemp =
        hotelService.getHotelListModel(HotelService.filter);
    return hotelListTemp;
  }
}
