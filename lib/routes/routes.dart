import 'package:flutter/material.dart';

import '../screens/completed_notes_chart_screen.dart';
import '../screens/completed_notes_screen.dart';
import '../screens/home_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/': (context) => Home(),
    '/complete': (context) => CompleteNoteScreen(),
    '/chart': (context) => CompleteNotesChartScreen(),
  };

  static String initial = '/';
  static String schedule = '/schedule-page';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
