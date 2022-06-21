import 'package:flutter/material.dart';

class Constants {
  static var QAREEID = "QareeId";
  static var SPEED = "Speed";
  static var SOUND = "SoundVol";
  static var LASTREAD = "LastRead";
  static var FONTSIZE = "FontSize";

  static Color mainColor = const Color(0xfff0f730c);
  static ThemeData darkTheme = ThemeData(
      accentColor: Colors.red,
      brightness: Brightness.light,
      primaryColor: Colors.black87,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black38,
        disabledColor: Colors.grey,
      ));

  static ThemeData lightTheme = ThemeData(
      accentColor: Colors.pink,
      brightness: Brightness.light,
      primaryColor: Colors.white,
      // appBarTheme: ,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.green,
        disabledColor: Colors.grey,
      ));
}
