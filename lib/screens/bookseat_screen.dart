import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onschedule/screens/feedback_screen.dart';
import 'package:onschedule/screens/payment_details_screen.dart';
import 'package:onschedule/utilities/constants.dart';
import 'package:page_route_animator/page_route_animator.dart';

import '../controller/bus_controller.dart';
import '../models/bus_model.dart';

class BookSeat extends StatefulWidget {
  @override
  State<BookSeat> createState() => _BookSeatPageState();
  final String route;
  final String vnum;
  final String date;
  const BookSeat(
      {Key? key, required this.route, required this.vnum, required this.date})
      : super(key: key);
}

class _BookSeatPageState extends State<BookSeat> {
  //Set<SeatNumber> selectedSeats = {};
  final getData = [
    {
      'route': 'Colombo - Kandy',
      'busnum': 'LN-1256',
      'departure': 'Colombo',
      'arrival': 'Kandy',
      'ddate': '2023-04-12',
      'adate': '2023-04-12',
      'dtime': '1.00PM',
      'atime': '5.15PM',
      'price': 'Rs.550',
      'seat': '20'
    }
  ];

  final List<List<String>> seatNumbers = [
    ['1', '2', '', '', '3', '4'],
    ['5', '6', '', '', '7', '8'],
    ['9', '10', '', '', '11', '12'],
    ['13', '14', '', '', '15', '16'],
    ['17', '18', '', '', '19', '20'],
    ['21', '22', '', '', '23', '24'],
    ['25', '26', '', '', '27', '28'],
    ['29', '30', '', '', '31', '32'],
    ['33', '34', '', '', '35', '36'],
    ['37', '38', '', '', '39', '40'],
    ['41', '42', '', '', '43', '44'],
    ['', '', '', '', '45', '46'],
    ['', '', '', '', '47', '48'],
    ['49', '50', '51', '52', '53', '54'],
  ];

  final double spaceWidth = 10.0;
  final Set<String> selectedSeats = Set<String>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BusController());
    //final routes = widget.route;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(left: 75),
          child: const Text(
            'OnSchedule',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: FutureBuilder(
        future: controller.getSelectedBusData(widget.route, widget.vnum),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Bus busData = snapshot.data as Bus;

              List<int> array = busData.sstatus;
              List<int> bookedSeats = [];

              for (int i = 0; i < array.length; i++) {
                if (array[i] == 0) {
                  bookedSeats.add(i + 1);
                }
              }
              List<String> bookedSeat =
                  bookedSeats.map((seat) => seat.toString()).toList();

              //split route
              String str = busData.route;
              List<String> parts = str.split(" - ");
              String r1 = parts[0];
              String r2 = parts[1];

              //split dtime
              String str2 = busData.dt;
              List<String> parts2 = str2.split(" - ");
              String dt1 = parts2[1];

              //split atime
              String str3 = busData.at;
              List<String> parts3 = str3.split(" - ");
              String at1 = parts3[1];
              int onesCount =
                  busData.sstatus.where((element) => element == 1).length;

              int _totalprice = 0;

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Seat Bookings",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        width: double.maxFinite,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          color: const Color(0xFF00B050),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      height: 70,
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Text(
                                            busData.route,
                                            style: KpText,
                                          ),
                                          const Spacer(),
                                          Text(
                                            busData.vnum,
                                            style: KpText,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                                const SizedBox(height: 30),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      height: 350,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Departure - $r1",
                                              style: KpText,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Departure Date - ${widget.date}",
                                              style: KpText,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Departure Time - $dt1",
                                              style: KpText,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Center(
                                              child: Icon(
                                                Icons.arrow_downward,
                                                size: 25,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Arrival - $r2",
                                              style: KpText,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Arrival Date - ${widget.date}",
                                              style: KpText,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Arrival Time - $at1",
                                              style: KpText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                const SizedBox(height: 30),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      height: 120,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ticket Price - ${busData.price}",
                                              style: KpText,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Available Seats - $onesCount",
                                              style: KpText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(
                                              context,
                                              PageRouteAnimator(
                                                child: const BookSeat(
                                                    route: '',
                                                    vnum: '',
                                                    date: ''),
                                                routeAnimation:
                                                    RouteAnimation.rightToLeft,
                                                settings: const RouteSettings(
                                                    arguments: 'I am going'),
                                                curve: Curves.linear,
                                              ),
                                            );
                                          },
                                          style: KbookButton,
                                          child: const Text(
                                            "BACK",
                                            style: KpText,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              PageRouteAnimator(
                                                child: FeedbackScreen(
                                                    route: busData.route,
                                                    vnum: busData.vnum,
                                                    date: DateFormat(
                                                            'yyyy-MM-dd hh:mm a')
                                                        .format(
                                                            DateTime.now())),
                                                routeAnimation:
                                                    RouteAnimation.rightToLeft,
                                                settings: const RouteSettings(
                                                    arguments: 'I am going'),
                                                curve: Curves.linear,
                                              ),
                                            );
                                          },
                                          style: KSButton,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.feedback),
                                              SizedBox(width: 10),
                                              Text(
                                                "Feedback",
                                                style: KsText,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: 5,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return SizedBox(
                                width: double.infinity,
                                height: 1150,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text(
                                      "Front of bus is this side",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 850,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            for (final row in seatNumbers)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  for (final seat in row)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: seat.isNotEmpty
                                                            ? TextButton(
                                                                onPressed: () {
                                                                  if (!bookedSeat
                                                                      .contains(
                                                                          seat)) {
                                                                    setState(
                                                                        () {
                                                                      selectedSeats.contains(seat)
                                                                          ? selectedSeats.remove(
                                                                              seat)
                                                                          : selectedSeats
                                                                              .add(seat);
                                                                    });
                                                                  }
                                                                  int numberofseats =
                                                                      selectedSeats
                                                                          .length;
                                                                  int ticketprice =
                                                                      int.parse(
                                                                          busData
                                                                              .price);
                                                                  _totalprice =
                                                                      ticketprice *
                                                                          numberofseats;
                                                                },
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty
                                                                          .all<
                                                                              Color>(
                                                                    bookedSeat.contains(
                                                                            seat)
                                                                        ? Colors
                                                                            .red // set the background color to red for already booked seats
                                                                        : selectedSeats.contains(seat)
                                                                            ? const Color(0xFF00B050)
                                                                            : Colors.grey[300]!,
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  seat,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              )
                                                            : SizedBox(
                                                                width:
                                                                    spaceWidth),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                color: const Color(0xffD3D3D3),
                                              ),
                                              const SizedBox(width: 2),
                                              const Text(' Available')
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                color: Colors.red,
                                              ),
                                              const SizedBox(width: 2),
                                              const Text(' Sold')
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                color: const Color(0xFF00B050),
                                              ),
                                              const SizedBox(width: 2),
                                              const Text(' Selected')
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Seat No - ${selectedSeats.join(" , ")}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Ticket Price - RS $_totalprice.00",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      style: KbookButton,
                                      onPressed: () {
                                        if (selectedSeats.isNotEmpty) {
                                          Navigator.push(
                                            context,
                                            PageRouteAnimator(
                                              child: PaymentDetailsScreen(
                                                  busnum: busData.vnum,
                                                  route: busData.route,
                                                  time: busData.dt,
                                                  atime: busData.at,
                                                  seatnum:
                                                      selectedSeats.toString(),
                                                  price: _totalprice.toString(),
                                                  date: widget.date),
                                              routeAnimation:
                                                  RouteAnimation.rightToLeft,
                                              settings: const RouteSettings(
                                                  arguments: 'I am going'),
                                              curve: Curves.linear,
                                            ),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors
                                                              .orangeAccent,
                                                        ),
                                                        child: const Icon(
                                                          Icons.error,
                                                          size: 58,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      const Text(
                                                        "Please Select a Seat",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 22),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: const Text("Proceed"),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ]),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text('Something Went Wrong'),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
