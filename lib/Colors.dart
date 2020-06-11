import 'package:flutter/material.dart';

Color pinkey = Color(0xFFFF5767);
Color move = Color(0xFF433bc9);
Color greeny = Color(0xFF1CeDC1);
Color background = Color(0xFFf0f2fc);
Color textcolor = Color(0xFF162640);
Color orangey = Color(0xFFffab55);
MaterialColor primary = MaterialColor(0xFF880E4F, color);
Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

TextStyle simple(var height) {
  return TextStyle(
      color: textcolor,
      fontSize: 0.0245 * height,
      fontWeight: FontWeight.bold,
      fontFamily: 'Avenir');
}

TextStyle titlesmall(var height) {
  return TextStyle(
      color: Colors.white,
      fontSize: 0.0245 * height,
      fontFamily: 'Avenir',
      fontWeight: FontWeight.bold);
}

TextStyle title(var height) {
  return TextStyle(
      color: Colors.white,
      fontSize: 0.0256 * height,
      fontFamily: 'Avenir',
      fontWeight: FontWeight.bold);
}

TextStyle simplepink(var height) {
  return TextStyle(
      color: pinkey,
      fontSize: 0.0245 * height,
      fontWeight: FontWeight.bold,
      fontFamily: 'Avenir');
}

TextStyle titlebl(var height) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 0.0306 * height,
    fontFamily: 'Avenir',
  );
}

TextStyle titleblack(var height) {
  return TextStyle(
    color: Colors.black,
    fontSize: 0.0306 * height,
    fontFamily: 'Avenir',
  );
}

TextStyle selectedtitleblack(var height) {
  return TextStyle(
    color: move,
    fontSize: 0.0306 * height,
    fontFamily: 'Avenir',
  );
}

TextStyle lossstyle(var height) {
  return TextStyle(
    color: Colors.red,
    fontSize: 0.0306 * height,
    fontFamily: 'Avenir',
  );
}

TextStyle winstyle(var height) {
  return TextStyle(
    color: Colors.green,
    fontSize: 0.0306 * height,
    fontFamily: 'Avenir',
  );
}

TextStyle notvalid(var height) {
  return TextStyle(
    color: Colors.red,
    fontSize: 0.0196 * height,
    fontFamily: 'Avenir',
  );
}
