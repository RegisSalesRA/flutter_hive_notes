import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'data/notification/notification_service.dart';
import 'models/note.dart';

Future main() async {
  // Voce precisa adicionar isso para que o flutter aceite voce rodar codigo antes do MyApp
  // O codigo do hive fica sendo chamado antes do Myapp
  WidgetsFlutterBinding.ensureInitialized();

  //Iniciar o banco Hive
  await Hive.initFlutter();
  //Registrar box ( Box is like doc firebase)
  Hive.registerAdapter(NoteAdapter());
  // Aqui criamos a box e colocamos o nome onde vai ser inserido os dados
  await Hive.openBox<Note>('notes');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NotificationService()),
    ],
    child: App(),
  ));
}
