import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  String choices;

  @HiveField(3)
  String analise;

  Item({this.nome, this.isCompleted, this.choices, this.analise});
}
