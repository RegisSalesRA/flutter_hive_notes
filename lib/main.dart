import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'config/app_theme.dart';
import 'data/notification/notification_service.dart';
import 'models/note.dart';

Future<void> setupTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}



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
  // TimeZone
  setupTimeZone();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NotificationService()),
    ],
    child: App(),
  ));
}
