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
  var selectedItem = '';
  bool isTaped = false;
  String search = "";
  int filterValue = 0;
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
            title: "Flutter Note",
            widgetAction: Row(children: [
              IconButton(
                color: ColorsTheme.primaryColor,
                icon: Icon(
                  Icons.refresh,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    filterValue = 0;
                  });
                  print(filterValue);
                },
              ),
              PopupMenuButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.more_vert,
                    color: ColorsTheme.primaryColor,
                  ),
                  onSelected: (value) {
                    setState(() {
                      filterValue = value;
                    });
                    print(value);
                  },
                  itemBuilder: (BuildContext bc) {
                    return [
                      PopupMenuItem(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Home notes")
                            ]),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.work_outlined,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Job notes")
                            ]),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.crisis_alert_rounded,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Urgency notes")
                            ]),
                        value: 3,
                      )
                    ];
                  })
            ]),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: filterValue == 0
                  ? NoteListWidget(
                      onTap: onTap,
                      isTaped: isTaped,
                      boxform: boxform,
                      search: search,
                      onChanged: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                    )
                  : NoteListFilterWidget(
                      onTap: onTap,
                      isTaped: isTaped,
                      boxform: boxform,
                      search: search,
                      onChanged: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                      filterValue: filterValue,
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
