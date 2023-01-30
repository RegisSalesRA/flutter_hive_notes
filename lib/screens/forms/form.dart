import 'package:flutter/material.dart';

import '../../config/colors.dart';
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
  Note objectNote =
      Note(name: "", urgency: "", isComplete: false, createdAt: DateTime.now());

  List<Map<String, dynamic>> noteCategory = [
    {"name": "Home"},
    {"name": "Job"},
  ];
  List<Map<String, dynamic>> noteCategory2 = [
    {"name": "Urgency"},
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      noteCategory.addAll(noteCategory2);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      setState(() {
        note = ModalRoute.of(context)!.settings.arguments;
        controller.text = note.name;
      });
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          objectNote.name = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropDownWidget(
                      hint: objectNote.urgency == null
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'Select option',
                                style: TextStyle(
                                    fontSize: 18, color: ColorsTheme.textColor),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                objectNote.urgency,
                                style: TextStyle(color: ColorsTheme.textColor),
                              ),
                            ),
                      dropdownItens: noteCategory.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val["name"],
                            child:
                                Container(width: 100, child: Text(val["name"])),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            objectNote.urgency = val!;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (noteForm.currentState!.validate()) {
                            NoteService.insertNote(objectNote);
                          }
                          Navigator.of(context).pop();
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
