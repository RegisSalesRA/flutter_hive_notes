import 'dart:math';

import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late int id;

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
      {int? id,
      required this.name,
      required this.urgency,
      required this.isComplete,
      required this.payload,
      required this.dateTime,
      required this.createdAt}) {
    this.id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;
  }
}
