import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hive/models/note.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../../routes/routes.dart';
import '../note/note_service.dart';

class NotificationService extends ChangeNotifier {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  setupNotifications() async {
    await _setupTimeZone();
    await _initalizeNotifications();
  }

  List<Note> listScheduleProvider = [];

  Future<List<Note>> loadNotificationHive() {
    final List<Note> schdules = NoteService.loadNotes().values.toList().cast();
    // print("Load loadNotificationHive $listScheduleProvider");
    return Future.value(schdules);
  }

  void loadSchedule() async {
    final loadNotification = await loadNotificationHive();
    listScheduleProvider = [...loadNotification];
    // print("Load Schedule $listScheduleProvider");
    notifyListeners();
  }

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    loadNotificationHive().then((_) => loadSchedule());
    setupNotifications();
  }

  Future<void> _setupTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  _initalizeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
        const InitializationSettings(android: android),
        onSelectNotification: _onSelectNotification);
  }

  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.of(Routes.navigatorKey!.currentContext!)
          .pushReplacementNamed(payload);
    }
  }

  ///listScheduleProvider.where((element) => element.datTime.is )
  ///DateTime (2023-01-31 15:03:00.000)
  showNotification(List<Note> listScheduleProvider) async {
    androidDetails = const AndroidNotificationDetails(
        'lembretes_notifications', 'Lembretes',
        channelDescription: "Este canal é para estudos de lembretes",
        importance: Importance.high,
        priority: Priority.max,
        enableLights: true,
        enableVibration: true);

    Iterable<Note> filtrados = listScheduleProvider.where((Note element) =>
        element.dateTime.isAfter(tz.TZDateTime.from(DateTime.now(), tz.local)));

    print("Não Filtrados ${listScheduleProvider.length}");
    print("Filtrados ${filtrados.length}");
    print("Filtrados Teste hora sem Timezone ${DateTime.now()}");
    print(
        "Filtrados Teste hora Timezone ${tz.TZDateTime.from(DateTime.now(), tz.local)}");
    if (filtrados.isNotEmpty) {
      for (var schedule in filtrados.toList()) {
        localNotificationsPlugin.zonedSchedule(
            Random.secure().nextInt(10000 - 1000) + 1000,
            schedule.name,
            schedule.urgency,
            tz.TZDateTime.from(schedule.dateTime, tz.local),
            NotificationDetails(
              android: androidDetails,
            ),
            payload: schedule.payload,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
      }
    }
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
}
