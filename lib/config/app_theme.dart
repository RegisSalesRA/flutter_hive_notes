import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive/routes/routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'config.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

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
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(title ?? ''),
                  content: Text(body ?? ''),
                ),
              );
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  _onSelectNotification(String? payload) {
    print("On selectNotification $payload");
    if (payload != null && payload.isNotEmpty) {
      Navigator.of(Routes.navigatorKey!.currentContext!)
          .pushReplacementNamed(payload);
    }
  }

  checkForNotifications() async {
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
    print(details);
  }

  Future<void> setupTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }
  // TimeZone

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
