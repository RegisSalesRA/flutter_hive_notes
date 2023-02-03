import 'package:hive/hive.dart';

import '../../models/note.dart';

class NoteService {
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
    //noteObject = !noteObject.isComplete;
    await todoBox.put(key, noteObject);
  }

  static void deleteNote(key) async {
    Box<Note> todoBox = Hive.box<Note>('notes');
    await todoBox.delete(key);
  }
}
