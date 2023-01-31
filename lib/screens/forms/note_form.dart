import 'package:flutter/material.dart';
import '../../data/note/note_service.dart';
import '../../helpers/helpers.dart';
import '../../models/note.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/dropdown_widget.dart';
import '../../widgets/input_text.dart';

class NoteForm extends StatefulWidget {
  final String? nameChange;
  final Note? noteObject;

  NoteForm({Key? key, this.nameChange, required this.noteObject})
      : super(key: key);
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final noteFormKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCategory = TextEditingController();
  List<Map<String, dynamic>> noteCategory = [
    {"name": "Home"},
    {"name": "Job"},
    {"name": "Urgency"},
  ];

  @override
  void initState() {
    if (widget.noteObject != null) {
      controllerName.text = widget.noteObject!.name;
      controllerCategory.text = widget.noteObject!.urgency;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*
    if (ModalRoute.of(context)!.settings.arguments != null) {
      note = ModalRoute.of(context)!.settings.arguments;
      setState(() {
        key = note.key;
      });
      widget.noteObject = NoteService.getNote(key);
    }
    */
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          widgetAction: SizedBox(),
          automaticallyImplyLeading: true,
          title: widget.noteObject == null ? "Create note" : "Update note",
        ),
        body: Center(
          child: Container(
            width: MediaQuerySize.widthSize(context) * 0.95,
            height: MediaQuerySize.heigthSize(context) * 0.95,
            padding: EdgeInsets.all(5),
            child: Form(
                key: noteFormKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    InputText(
                      controller: controllerName,
                      validator: (value) {
                        if (controllerName.text.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        value = controllerName.text;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropDownWidget(
                      hint: SizedBox(
                        width: 100,
                        child: Text(
                          widget.noteObject == null
                              ? "Select Option"
                              : widget.noteObject!.urgency,
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
                      onChanged: (value) {
                        controllerCategory.text = value!;
                      },
                      validator: (value) {
                        if (controllerCategory.text.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (noteFormKey.currentState!.validate()) {
                            if (widget.noteObject == null) {
                              Note objectNote = Note(
                                  name: controllerName.text,
                                  urgency: controllerCategory.text,
                                  isComplete: false,
                                  createdAt: DateTime.now());

                              NoteService.insertNote(objectNote);
                              Navigator.of(context).pop();
                            }
                            if ((widget.noteObject != null)) {
                              Note objectNote = Note(
                                  name: controllerName.text,
                                  urgency: controllerCategory.text,
                                  isComplete: false,
                                  createdAt: widget.noteObject!.createdAt);
                              NoteService.updateNote(
                                  widget.noteObject!.key, objectNote);
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Text(
                          widget.noteObject == null
                              ? "Create note"
                              : "Update note",
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
