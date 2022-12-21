import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../config/config.dart';
import '../models/note.dart';
import '../widgets/widget.dart';

class CompleteTaskScreen extends StatefulWidget {
  @override
  State<CompleteTaskScreen> createState() => _TaskListWidgetTestState();
}

class _TaskListWidgetTestState extends State<CompleteTaskScreen> {
  ValueListenable<Box<Note>> boxform = Hive.box<Note>('notes').listenable();
  int filterValueComplete = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottonSheetWidget(context, () {
              setState(() {
                filterValueComplete = 1;
              });
              Navigator.of(context).pop();
            }, () {
              setState(() {
                filterValueComplete = 2;
              });
              Navigator.of(context).pop();
            }, () {
              setState(() {
                filterValueComplete = 3;
              });
              Navigator.of(context).pop();
            }, filterValueComplete);
          },
          child: Icon(
            Icons.filter_alt,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBarWidget(
            automaticallyImplyLeading: false,
            title: "Complete notes",
            widgetAction: IconButton(
              color: ColorsTheme.primaryColor,
              icon: Icon(
                Icons.refresh,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  filterValueComplete = 0;
                });
              },
            )),
        body: SingleChildScrollView(
          child: Column(children: [
            CompleteNotesWidget(
              boxform: boxform,
              filterValueComplete: filterValueComplete,
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBarWidget(
          widgets: [
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
    );
  }
}
