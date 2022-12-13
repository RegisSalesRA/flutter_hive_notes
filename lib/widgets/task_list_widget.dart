// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../config/colors.dart';
import '../helpers/helpers.dart';
import '../models/task.dart';
import '../screens/forms/form.dart';
import 'widget.dart';

class TaskListWidget extends StatefulWidget {
  final ValueListenable<Box<Task>> boxform;
  final Size size;
  final String search;
  final Function onTap;
  final bool isTaped;

  final void Function(String) onChanged;

  const TaskListWidget({
    Key key,
    this.boxform,
    this.size,
    this.search,
    this.onTap,
    this.isTaped,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.boxform,
      builder: (context, Box<Task> box, _) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                  onChanged: widget.onChanged,
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
                  Task task = box.getAt(index);
                  return task.name
                          .toString()
                          .toLowerCase()
                          .contains(widget.search)
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                              height: 75,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.isTaped == false
                                          ? Colors.transparent
                                          : Colors.black,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
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
                                            style: task.isComplete == false
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
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          task.isComplete = !task.isComplete;
                                        });
                                        print("Task ${task.isComplete}");
                                      },
                                      icon: task.isComplete == false
                                          ? Icon(Icons.cancel_outlined)
                                          : Icon(Icons.check))
                                ],
                              )),
                        )
                      : Container();
                })
          ],
        );
      },
    );
  }
}


/*

   CheckBoxWidget(
                    checkedIten: Checkbox(
                      value: isComplete,
                      onChanged: (bool valor) {
                        setState(() {
                          isComplete = valor;
                        });
                      },
                    ),
                  ),


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
                                          onTap: () async {
                                            await showDialogWidget(
                                                context, task, box);
                                          },
                                          child: Icon(Icons.delete))
                                    ],
                                  )
*/