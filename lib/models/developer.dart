import 'package:hive/hive.dart';
part 'developer.g.dart';

@HiveType(typeId: 0)
class Developer extends HiveObject {

  @HiveField(1)
  String name;

  @HiveField(2)
  String choices;

  @HiveField(3)
  bool isGraduated;

  @HiveField(4)
  DateTime createdAt;

  Developer({this.name, this.isGraduated, this.choices, this.createdAt});
}