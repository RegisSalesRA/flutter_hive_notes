import 'package:flutter/material.dart';
import '../screens/completed_notes_screen.dart';
import '../screens/home_screen.dart';
import '../screens/screen_test.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/': (context) => Home(),
    '/complete': (context) => CompleteNoteScreen(),
    '/notificacao' : (context)=> TesteScreen(),
  };

  static String initial = '/';
  static String schedule = '/complete';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
