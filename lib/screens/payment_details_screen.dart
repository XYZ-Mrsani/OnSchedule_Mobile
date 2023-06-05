import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:live_currency_rate/live_currency_rate.dart';
import 'package:onschedule/controller/bookings_controller.dart';
import 'package:onschedule/controller/bus_controller.dart';
import 'package:onschedule/controller/transaction_controller.dart';
import 'package:onschedule/models/bookings_model.dart';
import 'package:onschedule/models/transaction_model.dart';
import 'package:onschedule/screens/home_screen.dart';
import 'package:onschedule/utilities/constants.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:http/http.dart' as http;

class PaymentDetailsScreen extends StatefulWidget {
  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();

  final String busnum;
  final String route;
  final String time;
  final String atime;
  final String seatnum;
  final String price;
  final String date;

  const PaymentDetailsScreen(
      {super.key,
      required this.busnum,
      required this.route,
      required this.time,
      required this.atime,
      required this.seatnum,
      required this.price,
      required this.date});
}

class _PaymentDetailsPageState extends State<PaymentDetailsScreen> {
  late String nic;
  late String fname;
  late String lname;
  late String phone;
  DateTime date = DateTime.now();

  final nic_txt = TextEditingController();
  final fname_txt = TextEditingController();
  final lname_txt = TextEditingController();
  final phone_txt = TextEditingController();

  Future<void> sendSMS(String phoneNumber, String message) async {
    var url = Uri.parse('https://app.notify.lk/api/v1/send');
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'to': phoneNumber,
          'message': message,
          'api_key': '6foKcoqeDhzeThB8k8QW',
          'sender_id': 'NotifyDEMO',
          'user_id': '24888'
        }));

    if (response.statusCode == 200) {
      print('SMS sent successfully.');
    } else {
      print('Failed to send SMS: ${response.body}');
    }
  }

  String _formattedPriceInUSD = '';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingsController());
    Get.put(TransactionController());
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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF00B050),
          ),
          margin: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Enter Your Details",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: controller.nic_txt,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: Colors.black,
                        ),
                        hintText: 'Enter your NIC Number',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (value) async {
                        nic = value;
                        CurrencyRate rate =
                            await LiveCurrencyRate.convertCurrency(
                                "LKR", "USD", double.parse(widget.price));

                        double priceInUSD =
                            double.parse(rate.result.toString());
                        _formattedPriceInUSD = priceInUSD.toStringAsFixed(2);

                        print(rate.result);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: controller.fname_txt,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: 'Enter your First Name',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (value) {
                        fname = value;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: controller.lname_txt,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: 'Enter your Last Name',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (value) {
                        lname = value;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: controller.phone_txt,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        hintText: 'Enter your Phone Number',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (value) {
                        phone = value;
                      },
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bus Number  - ${widget.busnum}",
                            style: KEdetails,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "From - ${widget.route.split("-")[0]}",
                            style: KEdetails,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "To - ${widget.route.split("-")[1]}",
                            style: KEdetails,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Time - ${widget.date + widget.time.split("-")[1]}",
                            style: KEdetails,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Seat Number - ${widget.seatnum.replaceAll('{', '').replaceAll('}', '')}",
                            style: KEdetails,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      "Ticket Price: RS ${widget.price}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 60,
                    margin: const EdgeInsets.only(
                        right: 20, left: 20, bottom: 10, top: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        /*String priceInLKR = '0';
                        setState(() {
                          priceInLKR = widget.price;
                        });*/

                        if (controller.nic_txt.text == '') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
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
                                        "NIC Number should Not be empty",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32),
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
                              );
                            },
                          );
                        } else if (controller.fname_txt.text == '') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
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
                                        "First Name should not be empty",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32),
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
                              );
                            },
                          );
                        } else if (controller.lname_txt.text == '') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
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
                                        "Last Name should not be empty",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32),
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
                              );
                            },
                          );
                        } else if (controller.phone_txt.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
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
                                        "Phone Number should not be empty",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32),
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
                              );
                            },
                          );
                        } else if (controller.phone_txt.text.length != 10) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
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
                                        "Phone Number Should have 10 digits",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 32),
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
                              );
                            },
                          );
                        } else {
                          /*showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 16),
                                    Text("Loading..."),
                                  ],
                                ),
                              );
                            },
                          );*/

                          final BuildContext parentContext = context;

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return UsePaypal(
                                sandboxMode: true,
                                clientId:
                                    "AWs8tNjRfW4i7SSiOEr9BWIawOmTEoQSyozCojmQpSnxiZygihJxYpCYbfh8jBNctIQLVp1uUNiDXv22",
                                secretKey:
                                    "EGHE1G5K_aZ_f9C382m-5MAb1bUFHK9boK8UJB4ltuee48YhU9YRJOTo3Pq3ZWUqaoTb0F1nX9A5VDpa",
                                returnURL: "https://samplesite.com/return",
                                cancelURL: "https://samplesite.com/cancel",
                                transactions: [
                                  {
                                    "amount": {
                                      "total": _formattedPriceInUSD,
                                      "currency": "USD",
                                      "details": {
                                        "subtotal": _formattedPriceInUSD,
                                        "shipping": '0',
                                        "shipping_discount": 0
                                      }
                                    },
                                    "description":
                                        "The payment transaction description.",
                                  },
                                ],
                                note:
                                    "Contact us for any questions on your Booking.",
                                onSuccess: (Map params) async {
                                  print("onSuccess: $params");

                                  String time =
                                      DateFormat('hh:mm a').format(date);
                                  final bookings = Bookings(
                                      datetime: '${widget.date} $time',
                                      nicnum: controller.nic_txt.text.trim(),
                                      fname: controller.fname_txt.text.trim(),
                                      lname: controller.lname_txt.text.trim(),
                                      phone: controller.phone_txt.text.trim(),
                                      from: widget.route.split("-")[0],
                                      to: widget.route.split("-")[1],
                                      seatnum: widget.seatnum
                                          .replaceAll('{', '')
                                          .replaceAll('}', ''),
                                      time: widget.date +
                                          widget.time.split("-")[1],
                                      busnum: widget.busnum,
                                      amount: 'RS ${widget.price}');

                                  BookingsController.instance
                                      .createBooking(bookings);

                                  final currentStatusFuture =
                                      BusController.instance.getSelectedBusData(
                                          widget.route, widget.busnum);
                                  final currentStatus =
                                      await currentStatusFuture;
                                  List<int> sstatus =
                                      List<int>.from(currentStatus.sstatus);

                                  List<String> seatNumbers = widget.seatnum
                                      .replaceAll('{', '')
                                      .replaceAll('}', '')
                                      .split(',')
                                      .map((e) => e.trim())
                                      .toList();

                                  for (String seatNumber in seatNumbers) {
                                    int seatIndex = int.parse(seatNumber) - 1;
                                    if (seatIndex >= 0 &&
                                        seatIndex < sstatus.length) {
                                      sstatus[seatIndex] = 0;
                                    }
                                  }

                                  BusController.instance.updateBusSeatsStatus(
                                      widget.busnum, sstatus);

                                  sendSMS(
                                      "94${controller.phone_txt.text.trim().substring(1)}",
                                      "Your seat has been successfully Booked Thank you!\n"
                                          "Route - ${widget.route}\n"
                                          "Bus Number - ${widget.busnum}\n"
                                          "Seat No - ${widget.seatnum}\n"
                                          "Amount - RS${widget.price}.00\n");

                                  final transaction = Transactions(
                                      datetime: widget.date,
                                      amount: widget.price,
                                      nicnum: controller.nic_txt.text.trim(),
                                      pname:
                                          "${controller.fname_txt.text.trim()} ${controller.lname_txt.text.trim()}",
                                      busnum: widget.busnum,
                                      at: "${widget.route.split("-")[1]}-${widget.atime.split("-")[1]}",
                                      dt: "${widget.route.split("-")[0]}${widget.time.split("-")[1]}",
                                      destination: widget.route.split("-")[1]);

                                  TransactionController.instance
                                      .createTransaction(transaction);

                                  await showDialog(
                                    context: parentContext,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Booking Confirmed",
                                          style: KpText,
                                        ),
                                        content: const Text(
                                          "Your seat has been booked.",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text("OK"),
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                PageRouteAnimator(
                                                  child: HomeScreen(),
                                                  routeAnimation: RouteAnimation
                                                      .rightToLeft,
                                                  settings: const RouteSettings(
                                                    arguments: 'I am going',
                                                  ),
                                                  curve: Curves.linear,
                                                ),
                                                (Route<dynamic> route) => false,
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  /* await Future.delayed(
                                      const Duration(seconds: 7));

                                  // Close the loading indicator dialog
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();*/
                                },
                                onError: (error) {
                                  print("onError: $error");
                                },
                                onCancel: (params) {
                                  print('cancelled: $params');
                                },
                              );
                            }),
                          );
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFFFA500))),
                      child: const Text(
                        "Pay Now",
                        style: KpText,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 60,
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFCE0B0B))),
                      child: const Text(
                        "Cancel",
                        style: KpText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
