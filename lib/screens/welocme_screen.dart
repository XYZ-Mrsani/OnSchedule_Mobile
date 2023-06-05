import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onschedule/screens/home_screen.dart';
import 'package:onschedule/utilities/constants.dart';
import 'package:page_route_animator/page_route_animator.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Center(child: Text('OnSchedule')),
      ),*/
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bus1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 80),
            Expanded(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Welcome To OnSchedule Transport Service",
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.alfaSlabOne(
                      textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));*/
                  Navigator.push(
                    context,
                    PageRouteAnimator(
                      child: HomeScreen(),
                      routeAnimation: RouteAnimation.rightToLeft,
                      settings: const RouteSettings(arguments: 'I am going'),
                      curve: Curves.linear,
                    ),
                  );
                },
                child: Container(
                  color: Color(0xFF00B050), //0xFFFFA500 orange
                  width: double.infinity,
                  height: 80,
                  child: const Center(
                    child: Text(
                      'NEXT',
                      style: KKWNext,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
