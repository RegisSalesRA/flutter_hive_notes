import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(1)
  String name;

  @HiveField(2)
  String urgency;

  @HiveField(4)
  bool isComplete;

  @HiveField(5)
  DateTime createdAt;

  Task({this.name, this.urgency, this.isComplete, this.createdAt});
}
