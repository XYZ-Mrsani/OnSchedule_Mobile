import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onschedule/controller/passenger_controller.dart';
import 'package:onschedule/models/passenger_model.dart';
import 'package:onschedule/screens/home_screen.dart';
import 'package:onschedule/utilities/constants.dart';
import 'package:page_route_animator/page_route_animator.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();

  final String route;
  final String vnum;
  final String date;
  const FeedbackScreen(
      {Key? key, required this.route, required this.vnum, required this.date})
      : super(key: key);
}

class _FeedbackPageState extends State<FeedbackScreen> {
  late String name = '';
  late String feedback = '';

  final nic_txt = TextEditingController();
  final fname_txt = TextEditingController();
  final lname_txt = TextEditingController();
  final phone_txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PassengerController());
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
          margin:
              const EdgeInsets.only(right: 25, left: 25, bottom: 15, top: 75),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Share your Feedback",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller.pname_txt,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      hintText: 'Enter Your Name',
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide.none),
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller.feedback_txt,
                    maxLines: 7,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your Feedback',
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide.none),
                    ),
                    onChanged: (value) {
                      feedback = value;
                    },
                  ),
                ),
                Container(
                  height: 150,
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
                          "Bus Number  - ${widget.vnum}",
                          style: KEdetails,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Route - ${widget.route}",
                          style: KEdetails,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Date - ${widget.date}",
                          style: KEdetails,
                        ),
                      ],
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
                      if (name == '') {
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
                                      "Name should Not be Empty",
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
                      } else if (feedback.toString() == '') {
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
                                      "Feedback should not be Empty",
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
                        final passenger = Passenger(
                            pname: controller.pname_txt.text,
                            datetime: widget.date,
                            feedback: controller.feedback_txt.text,
                            busnum: widget.vnum,
                            busroute: widget.route);

                        PassengerController.instance.createFeedback(passenger);

                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Feedback Sent",
                                style: KpText,
                              ),
                              content: const Text(
                                "Your Feedback has been sent.",
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
                                        routeAnimation:
                                            RouteAnimation.rightToLeft,
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
                      }
                    },
                    style: KbookButton,
                    child: const Text(
                      "Submit",
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
                    style: KCButton,
                    child: const Text(
                      "Cancel",
                      style: KpText,
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
