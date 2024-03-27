import 'package:flutter/material.dart';
import 'package:flutter_hive/config/theme/colors.dart';

TextTheme textThemeConfigLight() {
  return const TextTheme(
    titleLarge: TextStyle(
      fontSize: 18,
      overflow: TextOverflow.ellipsis,
      color: ColorsThemeLight.titleColor,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 16,
      color: ColorsThemeLight.textColor,
      decoration: TextDecoration.none,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      color: Color.fromARGB(255, 66, 62, 62),
      overflow: TextOverflow.ellipsis,
    ),
    headlineLarge: TextStyle(
      fontSize: 16,
      color: ColorsThemeLight.subtitleColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 16,
      color: ColorsThemeLight.textColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 15,
      color: ColorsThemeLight.subtitleColor,
    ),
    labelSmall: TextStyle(
        fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 16,
        color: ColorsThemeLight.primaryColor,
        fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
      fontSize: 16,
      color: ColorsThemeLight.buttonColorTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
  );
}
