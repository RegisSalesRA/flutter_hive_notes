import 'package:hive/hive.dart';

part 'developer.g.dart';

@HiveType(typeId: 0)
class Developer extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String choices;

  @HiveField(2)
  bool isGraduated;

  Developer({this.nome, this.isGraduated, this.choices});
}
