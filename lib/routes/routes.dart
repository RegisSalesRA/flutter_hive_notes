import 'package:flutter/material.dart';
import '../screens/completed_notes_chart_screen.dart';
import '../screens/completed_notes_screen.dart';
import '../screens/home_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/': (context) => const Home(),
    '/complete': (context) => const CompleteNoteScreen(),
    '/chart': (context) => const CompleteNotesChartScreen(),
  };

  static String initial = '/';
  static String complete = '/complete';
  static String chart = '/chart';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
