import 'package:flutter/material.dart';

TextTheme textThemeConfig() {
  return TextTheme(
    headline1: TextStyle(
      fontSize: 22,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 20,
        color: Colors.black,
        decoration: TextDecoration.none),
    headline5: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 20,
        color: Colors.black,
        decoration: TextDecoration.lineThrough),
    headline3: TextStyle(
      fontSize: 16,
      color: Colors.grey.shade400,
    ),
    headline4: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 18,
      color: Colors.white,
    ),
  );
}
