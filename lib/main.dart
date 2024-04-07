import 'package:flutter/material.dart';
import 'package:flutter_hive/models/goals.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'services/notification/notification_service.dart';
import 'models/note.dart';

Future main() async {
  // Voce precisa adicionar isso para que o flutter aceite voce rodar codigo antes do MyApp
  // O codigo do hive fica sendo chamado antes do Myapp
  WidgetsFlutterBinding.ensureInitialized();

  //Iniciar o banco Hive
  await Hive.initFlutter();
  //Registrar box ( Box is like doc firebase)
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(GoalsAdapter());
  // Aqui criamos a box e colocamos o nome onde vai ser inserido os dados
  await Hive.openBox<Note>('notes');
  await Hive.openBox<Goals>('goals');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NotificationService()),
    ],
    child: const App(),
  ));
}
