import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/notes/note_form.dart';
import 'package:flutter_hive/shared/empty_list_widget.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../animation/animation.dart';
import '../../config/theme/theme.dart';
import '../../helpers/helpers.dart';

import '../../services/note_hive/note_hive_service.dart';
import '../../models/note.dart';

class NoteListWidget extends StatefulWidget {
  final ValueListenable<Box<Note>> boxform;
  final String search;
  final TextEditingController textController;
  final void Function(String) onChanged;

  const NoteListWidget(
      {super.key,
      required this.boxform,
      required this.search,
      required this.onChanged,
      required this.textController});

  @override
  State<NoteListWidget> createState() => _NoteListWidgetState();
}

List<int>? keys;
List<int>? keysSort;

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
        List<int> keys = box.keys
            .cast<int>()
            .where((key) => box.get(key)!.isComplete == false)
            .toList();
        List<int> keysSort = keys.reversed.toList();

        if (keys.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                    controller: widget.textController,
                    onChanged: widget.onChanged,
                    decoration: const InputDecoration(
                      hintText: 'Search notes',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30.0,
                      ),
                    )),
              ),
              const SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  "Drag the card to the right to mark it complete",
                )),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: keysSort.length,
                  itemBuilder: (context, index) {
                    int key = keysSort[index];
                    Note? note = box.get(key);
                    if (note!.name
                        .toString()
                        .toLowerCase()
                        .contains(widget.search)) {
                      return AnimatedSlideText(
                        direction: 1,
                        child: Dismissible(
                            direction: DismissDirection.startToEnd,
                            key: Key(note.key.toString()),
                            background: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.update_sharp),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Complete",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
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
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Material(
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.transparent,
                                                blurRadius: 2.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(2.0, 2.0),
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey.shade400)),
                                        child: ExpansionTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              note.name,
                                              style: note.isComplete != false
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                            ),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              colorHelperText(note.urgency),
                                              Text(
                                                dataFormaterDateTimeHour(
                                                  note.dateTime,
                                                ),
                                                style: TextStyle(
                                                    color: timeDataExpired(
                                                        note.dateTime)),
                                              ),
                                            ],
                                          ),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          trailing: Icon(
                                            Icons.alarm_rounded,
                                            color:
                                                timeDataExpired(note.dateTime),
                                          ),
                                          tilePadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          children: <Widget>[
                                            ListTile(title: Text(note.name)),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    NoteForm(
                                                                      noteObject:
                                                                          note,
                                                                    )));
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());
                                                  },
                                                  child: const Text(
                                                    "Editar",
                                                    style: TextStyle(
                                                        color: ColorsThemeLight
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      );
                    } else {
                      return const SizedBox();
                    }
                  })
            ],
          );
        } else {
          return const EmptyListWidget();
        }
      },
    );
  }
}



/*

*/