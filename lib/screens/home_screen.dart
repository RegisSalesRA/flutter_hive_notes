import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/routes/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../config/config.dart';
import '../models/note.dart';
import '../widgets/widget.dart';
import 'note_form.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedItem = '';
  late Timer _timer;
  String search = "";
  TextEditingController controllerText = TextEditingController();
  int filterValue = 0;
  ValueListenable<Box<Note>> boxform = Hive.box<Note>('notes').listenable();

  @override
  void initState() {
    _timer =
        Timer.periodic(const Duration(seconds: 5), (timer) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NoteForm(
                        noteObject: null,
                      )));

              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: const Icon(
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
                icon: const Icon(
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
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10),
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
                icon: const Icon(
                  Icons.assignment_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  return;
                },
              ),
              const SizedBox(),
              IconButton(
                icon: Icon(
                  Icons.assignment_turned_in_outlined,
                  color: Colors.grey.shade300,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.complete);
                },
              ),
            ],
          )),
    );
  }
}
