import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../config/config.dart';
import '../widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String search = "";
  bool isTaped = false;

  ValueListenable<Box<Task>> boxform = Hive.box<Task>('tasks').listenable();

  onTap() {
    setState(() {
      isTaped = !isTaped;
    });
    print(isTaped);
  }

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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: AppBarWidget(
            automaticallyImplyLeading: false,
            title: "Flutter Task",
            widgetAction: Row(children: [
              IconButton(
                color: ColorsTheme.primaryColor,
                icon: Icon(
                  Icons.timer,
                  size: 30,
                ),
                onPressed: () {
                  print("Filter");
                },
              ),
              IconButton(
                color: ColorsTheme.primaryColor,
                icon: Icon(
                  Icons.more_vert,
                  size: 30,
                ),
                onPressed: () {
                  print("Filter");
                },
              ),
            ]),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TaskListWidget(
                onTap: onTap,
                isTaped: isTaped,
                boxform: boxform,
                search: search,
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
            ),
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
                      Icons.assignment_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      return null;
                    },
                  ),
                  SizedBox(),
                  IconButton(
                    icon: Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Colors.grey.shade300,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/complete');
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
