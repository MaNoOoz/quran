import 'package:flutter/material.dart';

class Constants {
  static var QAREEID = "QareeId";
  static var SPEED = "Speed";
  static var SOUND = "SoundVol";
  static var LASTREAD = "LastRead";
  static var FONTSIZE = "FontSize";
  static TextStyle mainStyleText = TextStyle(fontFamily: "Noor");
  static ButtonStyle mainStyleButton = ElevatedButton.styleFrom(primary: Colors.green);
  static String LoadingMessage = "إنتظر من فضلك";

  static Color mainColor = const Color(0xff0c3622);

  static ThemeData darkTheme = ThemeData(
      accentColor: Colors.red,
      brightness: Brightness.light,
      colorScheme: ColorScheme.dark(),
      primaryColor: Colors.black87,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black38,
        disabledColor: Colors.grey,
      ));

  static ThemeData lightTheme = ThemeData(
      accentColor: Colors.pink,
      brightness: Brightness.light,
      primaryColor: Colors.white10,
      // appBarTheme: ,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.green,
        disabledColor: Colors.grey,
      ));
}
