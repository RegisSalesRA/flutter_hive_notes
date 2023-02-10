import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../animation/animation.dart';
import '../../config/config.dart';
import '../../services/note_hive/note_hive_service.dart';
import '../../helpers/helpers.dart';
import '../../models/note.dart';
import '../../screens/note_form.dart';
import '../widget.dart';

class NoteListFilterWidget extends StatefulWidget {
  final ValueListenable<Box<Note>> boxform;
  final String search;
  final int filterValue;
  final TextEditingController textController;
  final void Function(String) onChanged;

  const NoteListFilterWidget(
      {Key? key,
      required this.boxform,
      required this.search,
      required this.onChanged,
      required this.textController,
      required this.filterValue})
      : super(key: key);

  @override
  State<NoteListFilterWidget> createState() => _NoteListFilterWidgetState();
}

List<int>? keysFilter;
List<int>? keysSortFilter;

class _NoteListFilterWidgetState extends State<NoteListFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.boxform,
      builder: (context, Box<Note> box, _) {
        if (widget.filterValue == 1) {
          keysFilter = box.keys
              .cast<int>()
              .where((key) =>
                  box.get(key)!.urgency == "Home" &&
                  box.get(key)!.isComplete == false)
              .toList();
        }
        if (widget.filterValue == 2) {
          keysFilter = box.keys
              .cast<int>()
              .where((key) =>
                  box.get(key)!.urgency == "Job" &&
                  box.get(key)!.isComplete == false)
              .toList();
        }
        if (widget.filterValue == 3) {
          keysFilter = box.keys
              .cast<int>()
              .where((key) =>
                  box.get(key)!.urgency == "Urgency" &&
                  box.get(key)!.isComplete == false)
              .toList();
        }
        List<int> keysSortFilter = keysFilter!.reversed.toList();
        if (keysFilter!.isNotEmpty) {
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
              Container(
                height: 50,
                child: Center(
                    child: Text(
                  "Drag the card to the right to mark it complete",
                  style: TextStyle(
                      color: Colors.grey.shade300, fontWeight: FontWeight.bold),
                )),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: keysSortFilter.length,
                  itemBuilder: (context, index) {
                    final int? key = keysSortFilter[index];
                    Note? note = box.get(key);
                    if (note!.name
                        .toString()
                        .toLowerCase()
                        .contains(widget.search)) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NoteForm(
                                    noteObject: note,
                                  )));
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: AnimatedSlideText(
                          direction: 1,
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
                                                  colorHelperText(note.urgency),
                                               
                                                  Text(dataFormaterDateTimeHour(
                                                      note.dateTime)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.alarm_rounded,
                                        color: timeDataExpired(note.dateTime),
                                      )
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
          return EmptyListWidget();
        }
      },
    );
  }
}
