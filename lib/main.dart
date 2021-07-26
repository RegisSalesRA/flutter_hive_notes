import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/form_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Iniciar o banco Hive
  await Hive.initFlutter();
  //Registrar box ( Box is like doc firebase)
  Hive.registerAdapter(FormModelAdapter());
  // Aqui criamos a box e colocamos o nome onde vai ser inserido os dados
  await Hive.openBox<FormModel>('todo2');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
