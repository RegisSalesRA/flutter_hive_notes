import 'package:flutter/material.dart';
import 'package:flutter_hive/models/note.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../routes/routes.dart';

class NotificationService extends ChangeNotifier {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails; 

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    setupNotifications();
  }

  setupNotifications() async {
    await _initalizeNotifications();
  }

  _initalizeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
        const InitializationSettings(android: android),
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
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
    print(details);
  }
 

 // Service
  Box<Note> noteBox = Hive.box<Note>('notes');


  insertNote(noteObject) {
    noteBox.add(noteObject);
    showNotification(noteObject);
  }

  updateNote(key, noteObject) async {
    await noteBox.put(key, noteObject);
    await removeScheduledAlarm(noteObject);
    await showNotification(noteObject);
  }

  showNotification(schedule) {
    androidDetails = const AndroidNotificationDetails(
        'lembretes_notifications', 'Lembretes',
        channelDescription: "Este canal é para estudos de lembretes",
        importance: Importance.max,
        priority: Priority.max,
        enableLights: true,
        enableVibration: true);
    print(schedule.payload);
    if (schedule.dateTime
        .isAfter(tz.TZDateTime.from(DateTime.now(), tz.local))) {
      localNotificationsPlugin.zonedSchedule(
          schedule.id,
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

  Future<void> removeScheduledAlarm(var schedule) async {
    try {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin.cancel(schedule.id);
      print("Sucesso ${schedule.dateTime}");
    } catch (e) {
      print("Erro ${schedule.dateTime}");
    }
  }
}
