import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/task.dart';
import 'forms/form.dart';
import '../widgets/widget.dart';

class GraduatedWidget extends StatelessWidget {
  const GraduatedWidget({
    Key key,
    @required this.boxform,
    @required this.size,
  }) : super(key: key);

  final ValueListenable<Box<Task>> boxform;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxform,
      builder: (context, Box<Task> box, _) {
        List<int> keys;

        keys = box.keys
            .cast<int>()
            .where((key) => box.get(key).isComplete)
            .toList();

        return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final int key = keys[index];
              final Task dev = box.get(key);

              return Text("");
            });
      },
    );
  }
}
