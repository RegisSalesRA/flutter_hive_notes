import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/app_theme.dart';
import 'models/developer.dart';

Future main() async {
  // Voce precisa adicionar isso para que o flutter aceite voce rodar codigo antes do MyApp
  // O codigo do hive fica sendo chamado antes do Myapp
  WidgetsFlutterBinding.ensureInitialized();

  //Iniciar o banco Hive
  await Hive.initFlutter();
  //Registrar box ( Box is like doc firebase)
  Hive.registerAdapter(DeveloperAdapter());
  // Aqui criamos a box e colocamos o nome onde vai ser inserido os dados
  await Hive.openBox<Developer>('developers');

  runApp(App());
}
