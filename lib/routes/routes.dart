import 'package:flutter/material.dart';
import '../screens/home_view/home_view.dart';
import '../screens/notes/completed_notes_chart_screen.dart';
import '../screens/notes/completed_notes_screen.dart';
import '../screens/notes/notes_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/': (context) => const HomeView(),
    '/notes': (context) => const NotesView(),
    '/notes/complete': (context) => const CompleteNoteScreen(),
    '/notes/chart': (context) => const CompleteNotesChartScreen(),
  };

  static String initial = '/';
  static String notes = '/notes';
  static String complete = '/notes/complete';
  static String chart = '/notes/chart';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
