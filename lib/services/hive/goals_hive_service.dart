import 'package:hive/hive.dart';

import '../../models/goals.dart';

class GoalsService {
  static void insertgoals(goalsObject) async {
    Box<Goals> todoBox = Hive.box<Goals>('goals');
    await todoBox.add(goalsObject);
  }

  static void updategoals(key, goalsObject) async {
    Box<Goals> todoBox = Hive.box<Goals>('goals');
    await todoBox.put(key, goalsObject);
  }

  static void updategoalsChecked(key, goalsObject) async {
    Box<Goals> todoBox = Hive.box<Goals>('goals');
    await todoBox.put(key, goalsObject);
  }

  static void deletegoals(key) async {
    Box<Goals> todoBox = Hive.box<Goals>('goals');
    await todoBox.delete(key);
  }
}
