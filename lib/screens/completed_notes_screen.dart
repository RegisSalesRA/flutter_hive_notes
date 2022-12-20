import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../config/config.dart';
import '../models/task.dart';
import '../widgets/widget.dart';

class CompleteTaskScreen extends StatefulWidget {
  @override
  State<CompleteTaskScreen> createState() => _TaskListWidgetTestState();
}

class _TaskListWidgetTestState extends State<CompleteTaskScreen> {
  ValueListenable<Box<Task>> boxform = Hive.box<Task>('tasks').listenable();
  int indexFilter = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 250,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(15.0),
                          topRight: const Radius.circular(15.0))),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 10,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Sort by",
                              style: Theme.of(context).textTheme.headline3,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    indexFilter = 1;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: indexFilter == 1
                                          ? ColorsTheme.primaryColor
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.home,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Home notes",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        )
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    indexFilter = 2;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: indexFilter == 2
                                          ? ColorsTheme.primaryColor
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.work_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Job notes",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        )
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    indexFilter = 3;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: indexFilter == 3
                                          ? ColorsTheme.primaryColor
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.crisis_alert_rounded,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Urgency notes",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(
            Icons.filter_alt,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBarWidget(
            automaticallyImplyLeading: false,
            title: "Complete tasks",
            widgetAction: IconButton(
              color: ColorsTheme.primaryColor,
              icon: Icon(
                Icons.refresh,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  indexFilter = 0;
                });
              },
            )),
        body: Column(children: [
          if (indexFilter == 0) ...{
            CompleteNotesWidget(boxform: boxform),
          } else if (indexFilter == 1) ...{
            CompleteNotesHomeWidget(
              boxform: boxform,
            )
          } else if (indexFilter == 2) ...{
            CompleteNotesJobWidget(
              boxform: boxform,
            ),
          } else if (indexFilter == 3) ...{
            CompleteNotesUrgencyWidget(
              boxform: boxform,
            )
          }
        ]),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.primary,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.assignment_outlined,
                    color: Colors.grey.shade300,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                SizedBox(),
                IconButton(
                  icon: Icon(
                    Icons.assignment_turned_in_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
