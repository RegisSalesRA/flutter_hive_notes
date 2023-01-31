import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../data/notification/notification_service.dart';
import '../models/note.dart';
import '../widgets/widget.dart';
import 'note_form.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedItem = '';
  String search = "";
  TextEditingController controllerText = TextEditingController();
  int filterValue = 0;
  ValueListenable<Box<Note>> boxform = Hive.box<Note>('notes').listenable();

  @override
  void initState() {
    Provider.of<NotificationService>(context, listen: false).loadSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteForm(
                        noteObject: null,
                      )));
              FocusScope.of(context).requestFocus(FocusNode());
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
                  FocusScope.of(context).requestFocus(FocusNode());
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
                      boxform: boxform,
                      search: search,
                      onChanged: (value) {
                        setState(() {
                          search = value.toLowerCase();
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
