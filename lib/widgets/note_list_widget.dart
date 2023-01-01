import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../animation/animation.dart';
import '../config/colors.dart';
import '../helpers/helpers.dart';
import '../models/note.dart';

class NoteListWidget extends StatefulWidget {
  final ValueListenable<Box<Note>> boxform;
  final String search;
  final Function onTap;
  final bool isTaped;
  final TextEditingController textController;
  final void Function(String) onChanged;

  const NoteListWidget(
      {Key key,
      this.boxform,
      this.search,
      this.onTap,
      this.isTaped,
      this.onChanged,
      this.textController})
      : super(key: key);

  @override
  State<NoteListWidget> createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.boxform,
      builder: (context, Box<Note> box, _) {
        if (box.isNotEmpty) {
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
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    Note note = box.getAt(index);
                    if (note.name
                        .toString()
                        .toLowerCase()
                        .contains(widget.search)) {
                      return AnimatedFadedText(
                        direction: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                              height: 75,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.isTaped == false
                                          ? Colors.transparent
                                          : Colors.black,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade400)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      if (note.urgency == "Home")
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      if (note.urgency == "Job")
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.orangeAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      if (note.urgency == "Urgency")
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuerySize.widthSize(
                                                    context) *
                                                0.70,
                                            child: Text(
                                              note.name ?? "default",
                                              style: note.isComplete != false
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                            ),
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
                                              Text(dateTimeFormat(
                                                  note.createdAt))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        setState(() {
                                          note.isComplete = !note.isComplete;
                                        });
                                        Note noteUpdate = Note(
                                            name: note.name,
                                            urgency: note.urgency,
                                            isComplete: note.isComplete,
                                            createdAt: note.createdAt);
                                        await box.put(note.key, noteUpdate);
                                        print(note.isComplete);
                                        print(noteUpdate.isComplete);
                                      },
                                      child: note.isComplete != false
                                          ? Icon(Icons.check_circle_outline)
                                          : Icon(Icons.circle_outlined))
                                ],
                              )),
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
