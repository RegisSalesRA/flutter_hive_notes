import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../helpers/helpers.dart';
import '../models/task.dart';

class CompleteNotesHomeWidget extends StatelessWidget {
  const CompleteNotesHomeWidget({
    Key key,
    @required this.boxform,
  }) : super(key: key);

  final ValueListenable<Box<Task>> boxform;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxform,
      builder: (context, Box<Task> box, _) {
        List<int> keys;

        keys = box.keys
            .cast<int>()
            .where((key) =>
                box.get(key).urgency == "Home" &&
                box.get(key).isComplete == true)
            .toList();

        if (keys.isNotEmpty) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                      "${keys.length} / ${boxform.value.values.length} ",
                      style: TextStyle(
                          color: Colors.grey.shade400,
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
                      final Task task = box.get(key);
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(task.key.toString()),
                        background: Container(color: Colors.transparent),
                        onDismissed: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            await box.delete(task.key);
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
                                        task.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      if (task.urgency == "Home")
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      if (task.urgency == "Job")
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      if (task.urgency == "Urgency")
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
                                            task.name ?? "default",
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Icon(Icons.circle_outlined)],
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ],
              ),
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
                    "No task avaliable",
                    style: TextStyle(color: Colors.grey.shade400),
                  )
                ]),
          );
        }
      },
    );
  }
}
