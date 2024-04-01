import 'package:flutter/material.dart';
import 'package:flutter_hive/models/note.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends ChangeNotifier {
  Box<Note> noteBox = Hive.box<Note>('notes');

  insertNote(noteObject) {
    noteBox.add(noteObject);
    showNotification(noteObject);
  }

  //8344
  updateNote(key, noteObject) async {
    await noteBox.put(key, noteObject);
    await removeScheduledAlarm(noteObject);
    await showNotification(noteObject);
  }

  showNotification(schedule) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('schedule', 'schedule',
            channelDescription: "Channel schedule",
            importance: Importance.max,
            priority: Priority.max,
            enableLights: true,
            enableVibration: true);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: null,
    );

    if (schedule.dateTime
        .isAfter(tz.TZDateTime.from(DateTime.now(), tz.local))) {
      flutterLocalNotificationsPlugin.zonedSchedule(
          schedule.id,
          schedule.name,
          schedule.urgency,
          tz.TZDateTime.from(schedule.dateTime, tz.local),
          platformChannelSpecifics,
          payload: schedule.payload, 
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future<void> removeScheduledAlarm(var schedule) async {
    try {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin.cancel(schedule.id);
      //print("Sucesso ${schedule.dateTime}");
    } catch (e) {
      //print("Erro ${schedule.dateTime}");
    }
  }
}
