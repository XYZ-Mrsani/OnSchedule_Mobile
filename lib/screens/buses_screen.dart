import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onschedule/controller/bus_controller.dart';
import 'package:onschedule/models/bus_model.dart';
import 'package:onschedule/screens/bookseat_screen.dart';
import 'package:onschedule/utilities/constants.dart';
import 'package:page_route_animator/page_route_animator.dart';

class Buses extends StatefulWidget {
  @override
  State<Buses> createState() => _BusesPageState();

  final String route;
  final String date;
  const Buses({Key? key, required this.route, required this.date})
      : super(key: key);
}

class _BusesPageState extends State<Buses> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BusController());
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
      body: FutureBuilder<List<Bus>>(
        future: controller.getAllUser(widget.route),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                List<Bus> busList = snapshot.data!;
                List<Bus> availableBuses =
                    busList.where((bus) => bus.availability == "Yes").toList();

                // for (Bus bus in busList) {
                //  if (bus.availability == "Yes") {
                if (availableBuses.isEmpty) {
                  return Center(
                    child: AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orangeAccent,
                              ),
                              child: const Icon(
                                Icons.bus_alert,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Today there are no available buses...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 32),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            'OK',
                            style: TextStyle(fontSize: 22),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Available Buses", //widget.route
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: availableBuses
                            .length, // snapshot.data!.length, //getData.length
                        itemBuilder: (context, index) {
                          Bus bus = availableBuses[index];
                          String str = bus.route;
                          List<String> parts = str.split(" - ");
                          String r1 = parts[0];
                          String r2 = parts[1];

                          //split dtime
                          String str2 = bus.dt;
                          List<String> parts2 = str2.split(" - ");
                          String dt1 = parts2[1];

                          //split atime
                          String str3 = bus.at; //busList[index].at;
                          List<String> parts3 = str3.split(" - ");
                          String at1 = parts3[1];

                          int onesCount = snapshot.data![index].sstatus
                              .where((element) => element == 1)
                              .length;

                          return Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            height: 720,
                            width: double.maxFinite,
                            margin: const EdgeInsets.only(bottom: 30),
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
                                                  snapshot.data![index].route
                                                  //busData.route,
                                                  ,
                                                  style: KpText,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  snapshot.data![index].vnum
                                                  //busData.vnum,
                                                  ,
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
                                              padding:
                                                  const EdgeInsets.all(12.0),
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
                                                    "Date - ${widget.date}",
                                                    style: KpText,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Time - $dt1",
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
                                                    "Date - ${widget.date}",
                                                    style: KpText,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Time - $at1",
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
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Ticket Price - RS ${snapshot.data![index].price}.00",
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
                                                  Navigator.push(
                                                    context,
                                                    PageRouteAnimator(
                                                      child: BookSeat(
                                                          route: snapshot
                                                              .data![index]
                                                              .route,
                                                          vnum: snapshot
                                                              .data![index]
                                                              .vnum,
                                                          date: widget.date),
                                                      routeAnimation:
                                                          RouteAnimation
                                                              .rightToLeft,
                                                      settings:
                                                          const RouteSettings(
                                                              arguments:
                                                                  'I am going'),
                                                      curve: Curves.linear,
                                                    ),
                                                  );
                                                },
                                                style: KbookButton,
                                                child: const Text(
                                                  "BOOK SEAT",
                                                  style: KpText,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
                // }
                //}
              } else {
                return Center(
                  child: AlertDialog(
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orangeAccent,
                            ),
                            child: const Icon(
                              Icons.error,
                              size: 58,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "There Are No Buses Available in Your Selected Route...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text('something went wrong'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //return Container();
        },
        // child: ,
      ),
    );
  }
}
