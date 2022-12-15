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
          onPressed: () async {
            await Navigator.pushNamed(context, '/form');
            FocusScope.of(context).unfocus();
          },
          child: Icon(
            Icons.add,
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
                                        onTap: () async {
                                          await showDialogWidget(
                                              context, task, box);
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
                    color: Colors.white,
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


/*

 

ListTile(
                                  onTap: onTap,
                                  trailing: InkWell(
                                      onTap: () => print("teste"),
                                      child: Icon(Icons.assignment)),
                                  title: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      task.name ?? "default",
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  subtitle:
                                      Text(dateTimeFormat(dev.createdAt)))





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


                                      InkWell(
                                      onTap: onTap,
                                      child: Icon(Icons.assignment))







                                      //////////////////////// UPDATE AND DELETE
                                      
                                  
*/