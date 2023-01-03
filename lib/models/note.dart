import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(1)
  String name;

  @HiveField(2)
  String urgency;

  @HiveField(3)
  bool isComplete;

  @HiveField(4)
  DateTime createdAt;

  Note({this.name, this.urgency, this.isComplete, this.createdAt});
}
