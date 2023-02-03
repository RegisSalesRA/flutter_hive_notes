import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../animation/animation.dart';
import '../../config/config.dart';
import '../../data/note/note_service.dart';
import '../../helpers/helpers.dart';
import '../../models/note.dart';
import '../../screens/note_form.dart';

class NoteListWidget extends StatefulWidget {
  final ValueListenable<Box<Note>> boxform;
  final String search;
  final TextEditingController textController;
  final void Function(String) onChanged;

  const NoteListWidget(
      {Key? key,
      required this.boxform,
      required this.search,
      required this.onChanged,
      required this.textController})
      : super(key: key);

  @override
  State<NoteListWidget> createState() => _NoteListWidgetState();
}

List<int>? keys;
final ValueNotifier<DateTime> dateTime =
    ValueNotifier<DateTime>(DateTime.now());
String formattedTime = DateFormat('kk:mm').format(DateTime.now());
String hour = DateFormat('a').format(DateTime.now());

class _NoteListWidgetState extends State<NoteListWidget> {


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.boxform,
      builder: (context, Box<Note> box, _) {
        keys = box.keys
            .cast<int>()
            .where((key) => box.get(key)!.isComplete == false)
            .toList();
        if (keys!.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                    controller: widget.textController,
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
                  itemCount: keys!.length,
                  itemBuilder: (context, index) {
                    final int key = keys![index];
                    Note? note = box.get(key);
                    if (note!.name
                        .toString()
                        .toLowerCase()
                        .contains(widget.search)) {
                      return AnimatedSlideText(
                        direction: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NoteForm(
                                      noteObject: note,
                                    )));
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Dismissible(
                            direction: DismissDirection.startToEnd,
                            key: Key(note.key.toString()),
                            background: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.update_sharp),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Complete",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                        ],
                                      ))),
                            ),
                            onDismissed: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                setState(() {
                                  note.isComplete = !note.isComplete;
                                });
                                NoteService.updateNoteChecked(key, note);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                  height: 75,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.transparent,
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
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                note.name,
                                                style: note.isComplete != false
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
                                              Row(
                                                children: [
                                                  if (note.urgency == "Urgency")
                                                    Text(
                                                      "${note.urgency} - ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red),
                                                    ),
                                                  if (note.urgency == "Job")
                                                    Text(
                                                      "${note.urgency} - ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.orange),
                                                    ),
                                                  if (note.urgency == "Home")
                                                    Text(
                                                      "${note.urgency} - ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green),
                                                    ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(note.dateTime.toString())
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.alarm_rounded,
                                        color: timeDataExpired(note.dateTime),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
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
                    "No note avaliable",
                    style: TextStyle(color: Colors.grey.shade400),
                  )
                ]),
          );
        }
      },
    );
  }
}
