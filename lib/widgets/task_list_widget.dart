import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../config/colors.dart';
import '../helpers/helpers.dart';
import '../models/task.dart';

class TaskListWidget extends StatefulWidget {
  final ValueListenable<Box<Task>> boxform;
  final String search;
  final Function onTap;
  final bool isTaped;

  final void Function(String) onChanged;

  const TaskListWidget({
    Key key,
    this.boxform,
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
        if (box.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                    onChanged: widget.onChanged,
                    style: const TextStyle(color: ColorsTheme.textInput),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
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
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
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
                                            Text(
                                                dateTimeFormat(task.createdAt)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            task.isComplete = !task.isComplete;
                                          });
                                          print("Task ${task.isComplete}");
                                        },
                                        icon: task.isComplete != false
                                            ? Icon(Icons.clear_outlined)
                                            : Icon(Icons.check))
                                  ],
                                )),
                          )
                        : SizedBox();
                  })
            ],
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
