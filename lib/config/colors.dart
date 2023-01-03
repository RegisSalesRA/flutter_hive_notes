import 'package:flutter/material.dart';

class ColorsTheme {
  static const MaterialColor themeColor = MaterialColor(
    0xffa0aefc, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF004999), //10%
      100: Color(0xFF004999), //20%
      200: Color(0xFF00254d), //30%
      300: Color(0xFF00254d), //40%
      400: Color(0xFF00254d), //50%
      500: Color(0xFF021338), //60%
      600: Color(0xFF021338), //70%
      700: Color(0xFF021338), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const Color primaryColor = Color(0xFFa0aefc);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textInput = Color(0xFF000000);
}
