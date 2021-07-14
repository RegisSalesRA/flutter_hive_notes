import 'package:hive/hive.dart';

import 'model/todo_model.dart';

class Boxes {
  static Box<TodoModel> getTodo() => Hive.box<TodoModel>('todo');
}
