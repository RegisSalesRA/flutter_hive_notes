import 'package:flutter/material.dart';
import 'package:flutter_hive/css/colors.dart';
import 'package:flutter_hive/screens/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev Hive',
      theme: ThemeData(
        primaryColor: CustomColors.theme,
      ),
      home: Home(),
    );
  }
}
