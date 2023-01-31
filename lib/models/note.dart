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

  @HiveField(5)
  String payload;

  @HiveField(6)
  DateTime dateTime;

  Note(
      {required this.name,
      required this.urgency,
      required this.isComplete,
      required this.payload,
      required this.dateTime,
      required this.createdAt});
}
