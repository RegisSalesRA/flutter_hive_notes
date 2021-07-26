import 'package:hive/hive.dart';

part 'form_model.g.dart';

@HiveType(typeId: 0)
class FormModel extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  String choices;

  FormModel({this.nome, this.isCompleted, this.choices});
}
