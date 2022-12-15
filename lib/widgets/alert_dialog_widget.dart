import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/task.dart';

showDialogWidget(BuildContext context, Task dev, Box<Task> box) async {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Center(child: const Text('Alert')),
      content: Text('Wish delete ${dev.name} ?'),
      actions: <Widget>[
        Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await box.delete(dev.key);
              Navigator.pop(context, 'Confirm');
            },
            child: const Text('Confirm'),
          ),
        ])),
      ],
    ),
  );
}
