import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../config/colors.dart';
import '../helpers/helpers.dart';
import '../models/developer.dart';
import '../screens/forms/form.dart';
import 'widget.dart';

class TaskListWidget extends StatelessWidget {
  final ValueListenable<Box<Developer>> boxform;
  final Size size;
  final String search;
  final void Function(String) onChanged;

  const TaskListWidget({
    Key key,
    this.boxform,
    this.size,
    this.search,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxform,
      builder: (context, Box<Developer> box, _) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                  onChanged: onChanged,
                  style: const TextStyle(color: ColorsTheme.textInput),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: ColorsTheme.textInput),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: ColorsTheme.textColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Search notes',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                  )),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: box.length,
                itemBuilder: (context, index) {
                  Developer dev = box.getAt(index);
                  return dev.name.toString().toLowerCase().contains(search)
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade400)),
                              child: ListTile(
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TaskForm(
                                                  id: dev.key,
                                                  nameChange: dev.name,
                                                )));
                                  },
                                  onLongPress: () async {
                                    await showDialogWidget(context, dev, box);
                                  },
                                  trailing: Icon(Icons.assignment),
                                  title: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      dev.name ?? "default",
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  subtitle:
                                      Text(dateTimeFormat(dev.createdAt)))),
                        )
                      : Container();
                })
          ],
        );
      },
    );
  }
}
