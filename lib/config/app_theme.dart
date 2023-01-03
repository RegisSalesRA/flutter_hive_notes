// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/completed_notes_screen.dart';
import '../screens/forms/form.dart';
import '../screens/home_screen.dart';
import 'config.dart';

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
        textTheme: textThemeConfig(),
        // Input Css
        inputDecorationTheme: inputDecorationThemeConfig(),
        // Button css
        buttonTheme: buttonThemeDataConfig(),
        floatingActionButtonTheme: floatingActionButtonThemeData(),
        iconTheme: IconThemeData(color: ColorsTheme.primaryColor),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/complete': (context) => CompleteNoteScreen(),
        '/form': (context) => NoteForm(),
      },
    );
  }
}
