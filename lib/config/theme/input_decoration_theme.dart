import 'package:flutter/material.dart';
import 'package:flutter_hive/config/theme/colors.dart';
 
InputDecorationTheme inputDecorationThemeConfig() {
  return InputDecorationTheme(
    labelStyle: const TextStyle(color: ColorsThemeLight.textColor),
    suffixIconColor: Colors.grey.shade400,
    filled: true,
    isDense: true,
    hintStyle: const TextStyle(color: ColorsThemeLight.textColor, fontSize: 15),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(width: 2, color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
    alignLabelWithHint: true,
  );
}