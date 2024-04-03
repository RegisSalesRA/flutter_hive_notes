import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/routes/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/note.dart';
import '../../widgets/widget.dart';
import 'note_form.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  NotesViewState createState() => NotesViewState();
}

class NotesViewState extends State<NotesView> {
  var selectedItem = '';
  String search = "";
  TextEditingController controllerText = TextEditingController();
  int filterValue = 0;
  ValueListenable<Box<Note>> boxform = Hive.box<Note>('notes').listenable();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NoteForm(
                        noteObject: null,
                      )));

              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: const Icon(
              Icons.add,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: AppBarWidget(
            automaticallyImplyLeading: false,
            leading: IconButton(
              color: Colors.grey.shade400,
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, Routes.initial, (route) => false),
            ),
            title: "Notes",
            widgetAction: Row(children: [
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.grey.shade400,
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
                  Icons.not_interested_sharp,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.notes);
                },
              ),
              const SizedBox(),
              IconButton(
                icon: const Icon(
                  Icons.check,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.complete);
                },
              ),
            ],
          )),
    );
  }
}
