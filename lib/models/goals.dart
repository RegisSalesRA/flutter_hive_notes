import 'dart:math';

import 'package:hive/hive.dart';
part 'goals.g.dart';

@HiveType(typeId: 0)
class Goals extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Metas> metas;

  @HiveField(3)
  DateTime createdAt;

  Goals(
      {int? id,
      required this.name,
      required this.metas,
      required this.createdAt}) {
    this.id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;
  }
}

class Metas {
  int? id;
  String? name;
  bool? done;

  Metas({required this.id, required this.name, required this.done});
}
