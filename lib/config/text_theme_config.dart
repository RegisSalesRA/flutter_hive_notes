import 'package:flutter/material.dart';
import 'package:flutter_hive/config/colors.dart';

TextTheme textThemeConfig() {
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 22,
      color: Colors.grey.shade400,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 20,
        color: Colors.black,
        decoration: TextDecoration.none),
    displaySmall: TextStyle(
      fontSize: 16,
      color: Colors.grey.shade400,
    ),
    headlineMedium: const TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 18,
      color: Colors.white,
    ),
    headlineSmall: const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 20,
        color: Colors.black,
        decoration: TextDecoration.lineThrough),
    titleLarge: const TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 22,
      color: ColorsTheme.primaryColor,
    ),
  );
}
