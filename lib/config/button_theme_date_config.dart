  import 'package:flutter/material.dart';

import 'config.dart';

 

ButtonThemeData buttonThemeDataConfig() {
    return ButtonThemeData(
        colorScheme:
            const ColorScheme.light(primary: ColorsTheme.primaryColor),
        buttonColor: ColorsTheme.primaryColor,
        splashColor: ColorsTheme.primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );
  }