import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../models/note.dart';

class NoteService extends ChangeNotifier {
  
  static void insertNote(noteObject) {
    Box<Note> todoBox = Hive.box<Note>('notes');
    todoBox.add(noteObject);
  }

  static void updateNote(noteObject) {
    Box<Note> todoBox = Hive.box<Note>('notes');
    todoBox.add(noteObject);
  }

  static void deleteNote(noteObject) {}
}
