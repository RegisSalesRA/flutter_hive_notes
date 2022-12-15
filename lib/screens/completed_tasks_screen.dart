import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../helpers/helpers.dart';
import '../models/task.dart';
import '../widgets/widget.dart';
import 'forms/form.dart';
import 'home_screen.dart';

class CompleteTaskScreen extends StatefulWidget {
  @override
  State<CompleteTaskScreen> createState() => _TaskListWidgetTestState();
}

class _TaskListWidgetTestState extends State<CompleteTaskScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  ValueListenable<Box<Task>> boxform = Hive.box<Task>('tasks').listenable();

  void removeItem(int index, var task, var box) async {
    _key.currentState.removeItem(
      index,
      (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text(""),
            ),
          ),
        );
      },
    );
    await box.delete(task.key);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => TaskForm()));
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
                  AnimatedList(
                    physics: NeverScrollableScrollPhysics(),
                    key: _key,
                    initialItemCount: box.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (_, index, animation) {
                      Task task = box.getAt(index);
                      return SizeTransition(
                        key: UniqueKey(),
                        sizeFactor: animation,
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
                                            style: task.isComplete != false
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
                                          Text(dateTimeFormat(task.createdAt)),
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
                                                          id: task.key,
                                                          nameChange: task.name,
                                                        )));
                                          },
                                          child: Icon(Icons.edit)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            removeItem(index, task, box);
                                          },
                                          child: Icon(Icons.delete))
                                    ],
                                  )
                                ],
                              )),
                        ),
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
                SizedBox(),
                IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CompleteTaskScreen()));
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

class CompletedTaskScreen2 extends StatefulWidget {
  const CompletedTaskScreen2({Key key}) : super(key: key);

  @override
  State<CompletedTaskScreen2> createState() => _CompletedTaskScreen2State();
}

class _CompletedTaskScreen2State extends State<CompletedTaskScreen2> {
  ValueListenable<Box<Task>> boxform = Hive.box<Task>('tasks').listenable();
  @override
  Widget build(BuildContext context) {
    return Container();
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