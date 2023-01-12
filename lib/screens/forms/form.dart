import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../config/colors.dart';
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
  String? name;
  String? urgency;

  void submitData() {
    if (noteForm.currentState!.validate()) {
      Box<Note> todoBox = Hive.box<Note>('notes');
      todoBox.add(Note(
          name: name!,
          urgency: urgency!,
          isComplete: false,
          createdAt: DateTime.now()));

      Navigator.pushNamed(context, '/');
    }
  }

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          widgetAction: SizedBox(),
          automaticallyImplyLeading: true,
          title: "Create note",
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
                      name: name,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropDownWidget(
                      hint: urgency == null
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
                                urgency!,
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
                            urgency = val;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        onPressed: submitData,
                        child: Text(
                          "Create note",
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
