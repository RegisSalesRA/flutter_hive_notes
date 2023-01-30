import 'package:flutter/material.dart';

import '../../data/note/note_service.dart';
import '../../helpers/helpers.dart';
import '../../models/note.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/dropdown_widget.dart';
import '../../widgets/input_text.dart';

class NoteForm extends StatefulWidget {
  final String? nameChange;

  NoteForm({Key? key, this.nameChange}) : super(key: key);
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final noteForm = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  var note;
  var key;
  Note objectNote =
      Note(name: "", urgency: "", isComplete: false, createdAt: DateTime.now());

  List<Map<String, dynamic>> noteCategory = [
    {"name": "Home"},
    {"name": "Job"},
    {"name": "Urgency"},
  ];

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      setState(() {
        note = ModalRoute.of(context)!.settings.arguments;
        key = note.key;
        objectNote = Note(
            name: controller.text,
            urgency: note.urgency,
            isComplete: note.isComplete,
            createdAt: note.createdAt);
      });
      print(note.key);
      print(objectNote);
      print(objectNote.name);
      print(objectNote.urgency);
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          widgetAction: SizedBox(),
          automaticallyImplyLeading: true,
          title: note == null ? "Create note" : "Update note",
        ),
        body: Center(
          child: Container(
            width: MediaQuerySize.widthSize(context) * 0.95,
            height: MediaQuerySize.heigthSize(context) * 0.95,
            padding: EdgeInsets.all(5),
            child: Form(
                key: noteForm,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    InputText(
                      controller: controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          controller.text = value!;
                          print(objectNote.name);
                          print(objectNote.urgency);
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropDownWidget(
                      hint: SizedBox(
                        width: 100,
                        child: Text(
                          note == null ? "Select Option" : note.urgency,
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade600),
                        ),
                      ),
                      dropdownItens: noteCategory.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val["name"],
                            child: SizedBox(
                                width: 100,
                                child: Text(
                                  val["name"],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade600),
                                )),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            objectNote.urgency = val!;
                            print(objectNote.name);
                            print(objectNote.urgency);
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            NoteService.updateNote(key, objectNote);
                          });
                          print(objectNote.name);
                          print(objectNote.urgency);
                          Navigator.of(context).pop();
                          /*
                          if (noteForm.currentState!.validate()) {
                            if (ModalRoute.of(context)!.settings.arguments ==
                                null) {
                              NoteService.insertNote(objectNote);
                              print(ModalRoute.of(context)!.settings.arguments);
                              Navigator.of(context).pop();
                            }
                            if ((ModalRoute.of(context)!.settings.arguments !=
                                null)) {
                              NoteService.updateNote(note.key, objectNote);
                              print(ModalRoute.of(context)!.settings.arguments);
                              Navigator.of(context).pop();
                            }
                          }
                          */
                        },
                        child: Text(
                          note == null ? "Create note" : "Update note",
                          style: Theme.of(context).textTheme.headline4,
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
