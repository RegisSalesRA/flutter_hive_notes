import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/models/note.dart';
import 'package:flutter_hive/routes/routes.dart';
import 'package:hive_flutter/adapters.dart';

import '../../widgets/widget.dart';

class CompleteNoteScreen extends StatefulWidget {
  const CompleteNoteScreen({super.key});

  @override
  State<CompleteNoteScreen> createState() => _NoteListWidgetTestState();
}

class _NoteListWidgetTestState extends State<CompleteNoteScreen> {
  ValueListenable<Box<Note>> boxform = Hive.box<Note>('notes').listenable();
  int filterValueComplete = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
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
          child: const Icon(
            Icons.filter_alt,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBarWidget(
            automaticallyImplyLeading: false,
            title: "Complete notes",
            widgetAction: Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: boxform,
                    builder: (context, Box<Note> box, _) {
                      List<int> keys;
                      keys = box.keys
                          .cast<int>()
                          .where((key) => box.get(key)!.isComplete)
                          .toList();
                      return keys.isEmpty
                          ? const IconButton(
                              icon: Icon(
                                Icons.pie_chart_outline,
                                size: 30,
                              ),
                              onPressed: null,
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.pie_chart_outline,
                                size: 30,
                              ),
                              onPressed: () async {
                                setState(() {
                                  filterValueComplete = 0;
                                });
                                await Navigator.pushNamed(
                                    context, Routes.chart);
                              },
                            );
                    }),
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      filterValueComplete = 0;
                    });
                  },
                )
              ],
            )),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
        ),
      ),
    );
  }
}
