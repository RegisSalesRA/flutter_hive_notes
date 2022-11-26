// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/home.dart';
import 'colors.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Flutter Sqflite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // PrimariColors from App css
        primarySwatch: ColorsTheme.themeColor,
        primaryColor: Colors.white,
        accentColor: ColorsTheme.primaryColor,
        backgroundColor: Colors.white,
        // Progress Indicator Css
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: ColorsTheme.primaryColor),
        // Text Css
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 20,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade400,
          ),
          headline4: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        // Input Css
        inputDecorationTheme: InputDecorationTheme(
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
                borderSide: BorderSide(width: 2, color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                  width: 2,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 2, color: Colors.grey.shade200)),
            alignLabelWithHint: true),
        // Button css
        buttonTheme: ButtonThemeData(
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
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsTheme.primaryColor,
        ),
        iconTheme: IconThemeData(color: ColorsTheme.primaryColor),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
      },
    );
  }
}
