import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../config/config.dart';
import '../helpers/helpers.dart';
import '../models/note.dart';

class CompleteNotesWidget extends StatelessWidget {
  const CompleteNotesWidget({
    Key key,
    @required this.boxform,
    @required this.filterValueComplete,
  }) : super(key: key);

  final ValueListenable<Box<Note>> boxform;
  final int filterValueComplete;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxform,
      builder: (context, Box<Note> box, _) {
        List<int> keys;
        List<int> keysIncomplete;
        int keysIncompleteIndex = 0;

        if (filterValueComplete == 0) {
          keys = box.keys
              .cast<int>()
              .where((key) => box.get(key).isComplete)
              .toList();
          keysIncompleteIndex = 0;
        }
        if (filterValueComplete == 1) {
          keys = box.keys
              .cast<int>()
              .where((key) =>
                  box.get(key).urgency == "Home" &&
                  box.get(key).isComplete == true)
              .toList();

          keysIncomplete = box.keys
              .cast<int>()
              .where((key) => box.get(key).urgency == "Home")
              .toList();
          keysIncompleteIndex = 1;
        }
        if (filterValueComplete == 2) {
          keys = box.keys
              .cast<int>()
              .where((key) =>
                  box.get(key).urgency == "Job" &&
                  box.get(key).isComplete == true)
              .toList();

          keysIncomplete = box.keys
              .cast<int>()
              .where((key) => box.get(key).urgency == "Job")
              .toList();

          keysIncompleteIndex = 2;
        }
        if (filterValueComplete == 3) {
          keys = box.keys
              .cast<int>()
              .where((key) =>
                  box.get(key).urgency == "Urgency" &&
                  box.get(key).isComplete == true)
              .toList();

          keysIncomplete = box.keys
              .cast<int>()
              .where((key) => box.get(key).urgency == "Urgency")
              .toList();

          keysIncompleteIndex = 3;
        }

        if (keys.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                if (keysIncompleteIndex == 0)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                      "${keys.length} / ${boxform.value.values.length}",
                      style: TextStyle(
                          color: keys.length != boxform.value.values.length
                              ? Colors.grey.shade400
                              : ColorsTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                if (keysIncompleteIndex != 0)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                      "${keys.length} / ${keysIncomplete.length}",
                      style: TextStyle(
                          color: keys.length != keysIncomplete.length
                              ? Colors.grey.shade400
                              : ColorsTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: keys.length,
                  shrinkWrap: true,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final int key = keys[index];
                    final Note note = box.get(key);
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(note.key.toString()),
                      background: Container(color: Colors.transparent),
                      onDismissed: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          await box.delete(note.key);
                        }
                      },
                      secondaryBackground: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      note.name,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.delete)
                                  ],
                                ))),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                            height: 75,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    if (note.urgency == "Home")
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    if (note.urgency == "Job")
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    if (note.urgency == "Urgency")
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.name ?? "default",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(dateTimeFormat(box.values
                                            .toList()[index]
                                            .createdAt)),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.check_circle_outline))
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: MediaQuerySize.heigthSize(context) * 0.85,
            width: MediaQuerySize.widthSize(context),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 50,
                  ),
                  Text(
                    "No note avaliable",
                    style: TextStyle(color: Colors.grey.shade400),
                  )
                ]),
          );
        }
      },
    );
  }
}
