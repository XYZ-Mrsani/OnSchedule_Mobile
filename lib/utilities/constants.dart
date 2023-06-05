import 'package:flutter/material.dart';

const KprimaryColor = MaterialColor(0xFF00B050, {
  50: Color(0xFFE0F2F1),
  100: Color(0xFFB2DFDB),
  200: Color(0xFF80CBC4),
  300: Color(0xFF4DB6AC),
  400: Color(0xFF26A69A),
  500: Color(0xFF009688),
  600: Color(0xFF00897B),
  700: Color(0xFF00796B),
  800: Color(0xFF00695C),
  900: Color(0xFF004D40),
});

final KWNextButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFA500)));
const KKWNext =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
const KpText = TextStyle(color: Colors.black, fontSize: 20);

const KsText = TextStyle(color: Colors.white, fontSize: 20);

const KpDate = TextStyle(color: Colors.black, fontSize: 25);

final KbookButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFA500)),
);
final KCButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFCE0B0B)),
);

final KSButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF003CFF)),
);

const KEdetails =
    TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
