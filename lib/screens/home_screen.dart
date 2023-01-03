import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../config/config.dart';
import '../models/note.dart';
import '../widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedItem = '';
  bool isTaped = false;
  String search = "";
  TextEditingController controllerText = TextEditingController();
  int filterValue = 0;
  ValueListenable<Box<Note>> boxform = Hive.box<Note>('notes').listenable();

  onTap() {
    setState(() {
      isTaped = !isTaped;
    });
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
            title: "Notes",
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
                    search = "";
                    controllerText.clear();
                  });
                  FocusScope.of(context).unfocus();
                },
              ),
              PopupMenuButtonWidget(
                onSelected: (value) {
                  setState(() {
                    filterValue = value;
                    search = "";
                    controllerText.clear();
                  });
                  FocusScope.of(context).unfocus();
                },
              )
            ]),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: filterValue == 0
                  ? NoteListWidget(
                      textController: controllerText,
                      onTap: onTap,
                      isTaped: isTaped,
                      boxform: boxform,
                      search: search,
                      onChanged: (value) {
                        setState(() {
                          search = value.toLowerCase();
                        });
                      },
                    )
                  : NoteListFilterWidget(
                      textController: controllerText,
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
          bottomNavigationBar: BottomAppBarWidget(
            widgets: [
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
          )),
    );
  }
}
