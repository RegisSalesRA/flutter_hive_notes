import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:flutter_hive/widgets/checkbox_widget.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../config/colors.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/dropdown_widget.dart';
import '../../widgets/input_text.dart';

class FormDeveloper extends StatefulWidget {
  final int id;
  final String nameChange;

  FormDeveloper({Key key, this.id, this.nameChange}) : super(key: key);
  @override
  _FormDeveloperState createState() => _FormDeveloperState();
}

class _FormDeveloperState extends State<FormDeveloper> {
  final developerForm = GlobalKey<FormState>();
  String name;
  String choices;
  bool isGraduated = false;

  void submitData() {
    final index = widget.id;
    if (index == null) {
      if (developerForm.currentState.validate()) {
        Box<Developer> todoBox = Hive.box<Developer>('developers');
        todoBox.add(Developer(
            name: name,
            isGraduated: isGraduated,
            choices: choices,
            createdAt: DateTime.now()));
        Navigator.of(context).pop();
      }
    } else {
      if (developerForm.currentState.validate()) {
        final index = widget.id;
        Developer developer = Developer(
            name: name,
            isGraduated: isGraduated,
            choices: choices,
            createdAt: DateTime.now());
        Box<Developer> todoBox = Hive.box<Developer>('developers');
        todoBox.put(index, developer);
        Navigator.of(context).pop();
      }
    }
  }

  List<Map<String, dynamic>> taskLevel = [
    {"name": "Junior"},
    {"name": "Pleno"},
    {"name": "Senior"},
  ];

  List<Map<String, dynamic>> taskLevel2 = [
    {"name": "Especialist"},
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      taskLevel.addAll(taskLevel2);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(
        title: widget.id == null ? "Create Developer" : widget.nameChange,
        actionsAppBar: Container(),
      ),
      body: Center(
        child: Container(
          width: size.width * 0.95,
          height: size.height * 0.95,
          padding: EdgeInsets.all(5),
          child: Form(
              key: developerForm,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  InputText(
                    name: name,
                    validator: (v) {
                      if (v.isEmpty) {
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
                    hint: choices == null
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
                              choices,
                              style: TextStyle(color: ColorsTheme.textColor),
                            ),
                          ),
                    dropdownItens: taskLevel.map(
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
                          choices = val;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CheckBoxWidget(
                    checkedIten: Checkbox(
                      value: isGraduated,
                      onChanged: (bool valor) {
                        setState(() {
                          isGraduated = valor;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                      onPressed: submitData,
                      child: widget.id == null
                          ? Text(
                              "Create Developer",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          : Text(
                              "Update Developer",
                              style: Theme.of(context).textTheme.headline4,
                            )),
                ],
              )),
        ),
      ),
    );
  }
}
