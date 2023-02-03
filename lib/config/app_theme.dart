import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive/routes/routes.dart';

import 'config.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {


  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Flutter Sqflite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // PrimariColors from App css
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        // Progress Indicator Css
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: ColorsTheme.primaryColor),
        // Text Css
        textTheme: textThemeConfig(),
        // Input Css
        inputDecorationTheme: inputDecorationThemeConfig(),
        // Button css
        buttonTheme: buttonThemeDataConfig(),
        floatingActionButtonTheme: floatingActionButtonThemeData(),
        iconTheme: IconThemeData(color: ColorsTheme.primaryColor),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: ColorsTheme.themeColor)
                .copyWith(secondary: ColorsTheme.primaryColor),
      ),
      initialRoute: Routes.initial,
      routes: Routes.list,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
