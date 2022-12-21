import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/note.dart';

showDialogWidget(BuildContext context, Note note, Box<Note> box) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Center(child: const Text('Alert')),
      content: Text('Wish delete ${note.name} ?'),
      actions: <Widget>[
        Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await box.delete(note.key);
              Navigator.pop(context, 'Confirm');
            },
            child: const Text('Confirm'),
          ),
        ])),
      ],
    ),
  );
}
