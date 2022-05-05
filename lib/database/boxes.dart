import 'package:hive/hive.dart';
import '../model/form_model.dart';

class Boxes {
  static Box<FormModel> getTodo() => Hive.box<FormModel>('todo');
}
