import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../models/note.dart';

class NoteService extends ChangeNotifier {
  static void insertNote(noteObject) async {
    Box<Note> todoBox = Hive.box<Note>('notes');
    await todoBox.add(noteObject);
  }

  static void updateNote(key, noteObject) async {
    Box<Note> todoBox = Hive.box<Note>('notes');
    await todoBox.put(key, noteObject);
  }

  static void updateNoteChecked(key, noteObject) async {
    Box<Note> todoBox = Hive.box<Note>('notes');
    await todoBox.put(key, noteObject);
  }

  static void deleteNote(noteObject) {}
}
