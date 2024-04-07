import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'goals.g.dart';

@HiveType(typeId: 1)
class Goals extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Metas> metas;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  bool isComplete;

  Goals(
      {int? id,
      required this.name,
      required this.isComplete,
      required this.metas,
      required this.createdAt}) {
    this.id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;
  }
}

class Metas {
  int? id;
  String? name;
  bool? done;
  TextEditingController? controller;
  Metas(
      {required this.id,
      required this.name,
      required this.done,
      required this.controller});
}
