import 'package:flutter/material.dart';

class Thems {
  static final appBarBackgroundColor = Color.fromARGB(224, 61, 29, 29);

  static final mainBackgroundColor = Color.fromARGB(255, 255, 255, 255);
  static final buttonStyle = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all<Color>(Color.fromARGB(255, 95, 138, 250)),
  );

  static final textFontFamily = "Manrope";

  static final textStyle = TextStyle(fontSize: 20, height: 1.4);
}
