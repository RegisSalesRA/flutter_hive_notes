import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'metas.g.dart';

@HiveType(typeId: 2)
class Metas extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool done;

  Metas(
      {int? id,
      required this.title,
      required this.description,
      required this.done}) {
    this.id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;
  }
}
