import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../helpers/helpers.dart';
import '../models/task.dart';
import '../widgets/widget.dart';
import 'forms/form.dart';

class CompleteTaskScreen extends StatefulWidget {
  @override
  State<CompleteTaskScreen> createState() => _TaskListWidgetTestState();
}

class _TaskListWidgetTestState extends State<CompleteTaskScreen> {
  ValueListenable<Box<Task>> boxform = Hive.box<Task>('tasks').listenable();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Filter");
          },
          child: Icon(
            Icons.filter_list_rounded,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBarWidget(
          automaticallyImplyLeading: false,
          title: "Complete tasks",
        ),
        body: ValueListenableBuilder(
          valueListenable: boxform,
          builder: (context, Box<Task> box, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        child: Center(child: Text("Numbers task")),
                      )),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: box.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      Task task = box.getAt(index);
                      return Padding(
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
                                    if (task.urgency == "Easy")
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    if (task.urgency == "Middle")
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    if (task.urgency == "Hard")
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
                                          style: box.values
                                                      .toList()[index]
                                                      .isComplete !=
                                                  false
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                              : Theme.of(context)
                                                  .textTheme
                                                  .headline2,
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
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TaskForm(
                                                        id: box.values
                                                            .toList()[index]
                                                            .key,
                                                        nameChange: box.values
                                                            .toList()[index]
                                                            .name,
                                                      )));
                                        },
                                        child: Icon(Icons.edit)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          showDialogWidget(context, task, box);
                                        },
                                        child: Icon(Icons.delete))
                                  ],
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
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
                    Icons.home,
                    color: Colors.grey.shade300,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                SizedBox(),
                IconButton(
                  icon: Icon(
                    Icons.check,
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
