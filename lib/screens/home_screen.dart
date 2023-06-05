import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onschedule/screens/buses_screen.dart';
import 'package:onschedule/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:page_route_animator/page_route_animator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  late String fromCity;
  late String toCity;
  DateTime date = DateTime.now();

  final from_txt = TextEditingController();
  final to_txt = TextEditingController();

  checkNull() {
    String from, to;
    from = from_txt.text;
    to = to_txt.text;
    if (from == '' || to == '') {
      print("cant be null");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  "Search Bus",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                color: const Color(0xFF26C281),
                margin: const EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 200,
                      margin: const EdgeInsets.only(
                          top: 25, left: 10, bottom: 10, right: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFFFFFFF))),
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1990),
                              lastDate: DateTime(2100));

                          if (newDate == null) {
                            return;
                          }
                          setState(() {
                            date = newDate;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  "Travel Date",
                                  textAlign: TextAlign.center,
                                  textStyle: GoogleFonts.robotoSlab(
                                    textStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  speed: const Duration(milliseconds: 100),
                                ),
                              ],
                            ),
                            Text(
                              DateFormat('d EEEE MMMM y').format(date),
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextField(
                        controller: from_txt,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          hintText: 'FROM',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide.none),
                        ),
                        onChanged: (value) {
                          fromCity = value;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextField(
                        controller: to_txt,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          hintText: 'TO',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide.none),
                        ),
                        onChanged: (value) {
                          toCity = value;
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 60,
                      margin: const EdgeInsets.all(50),
                      child: ElevatedButton(
                        onPressed: () {
                          String from, to;
                          from = from_txt.text;
                          to = to_txt.text;
                          if (from == '' || to == '') {
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
                                          "From or To should not be empty",
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
                            String from = from_txt.text.trim();
                            String to = to_txt.text.trim();
                            from = from.substring(0, 1).toUpperCase() +
                                from.substring(1);
                            to = to.substring(0, 1).toUpperCase() +
                                to.substring(1);
                            String route = '$from - $to';
                            DateTime dates = date;
                            Navigator.push(
                              context,
                              PageRouteAnimator(
                                child: Buses(
                                    route: route,
                                    date:
                                        DateFormat('yyyy-MM-dd').format(date)),
                                routeAnimation: RouteAnimation.rightToLeft,
                                settings: const RouteSettings(
                                    arguments: 'I am going'),
                                curve: Curves.linear,
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFFFA500))),
                        child: const Text(
                          "Search Bus",
                          style: KpText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
