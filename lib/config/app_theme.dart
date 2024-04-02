import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive/routes/routes.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import 'theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  setupNotifications() async {
    await _initalizeNotifications();
  }

  _initalizeNotifications() async {
    await setupTimeZone();
  }

  Future<void> setupTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  @override
  void initState() {
    setupNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        // PrimariColors from App css
        //  primaryColor: Colors.white,
        // Progress Indicator Css
        //  progressIndicatorTheme: progressIndicatorTheme(),
        // Text Css
        textTheme: textThemeConfigLight(),
        // Input Css
        //  inputDecorationTheme: inputDecorationThemeConfig(),
        // Button css 
        iconTheme: iconTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
          background: Colors.grey.shade200,
          error: Colors.red,
          onError: Colors.red,
          primary: const Color(0xFFeaddff),
        ),
      ),
      initialRoute: Routes.initial,
      routes: Routes.list,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
