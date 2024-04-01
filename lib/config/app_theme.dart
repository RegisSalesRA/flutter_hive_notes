import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive/routes/routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'config.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
        useMaterial3: true,
        // PrimariColors from App css
        primaryColor: Colors.white,
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
        iconTheme: const IconThemeData(color: ColorsTheme.primaryColor),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: ColorsTheme.themeColor)
                .copyWith(secondary: ColorsTheme.primaryColor)
                .copyWith(background: Colors.white),
      ),
      initialRoute: Routes.initial,
      routes: Routes.list,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
