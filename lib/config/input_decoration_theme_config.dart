import 'package:flutter/material.dart';

InputDecorationTheme inputDecorationThemeConfig() {
  return InputDecorationTheme(
      suffixIconColor: Colors.grey.shade400,
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 2,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 2, color: Colors.red)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 2,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade200)),
      alignLabelWithHint: true);
}
