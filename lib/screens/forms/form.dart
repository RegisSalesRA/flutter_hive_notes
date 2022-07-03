import 'package:flutter/material.dart';
import 'package:flutter_hive/css/colors.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:flutter_hive/widgets/appbar_widget.dart';
import 'package:flutter_hive/widgets/checkbox_widget.dart';
import 'package:hive/hive.dart';

import '../../widgets/dropdown_widget.dart';
import '../../widgets/input_text.dart';

class FormDeveloper extends StatefulWidget {
  int id = null;
  final String nomeChange;
  final developerForm = GlobalKey<FormState>();
  FormDeveloper({Key key, this.id, this.nomeChange}) : super(key: key);
  @override
  _FormDeveloperState createState() => _FormDeveloperState();
}

class _FormDeveloperState extends State<FormDeveloper> {
  String nome;
  String choices;
  bool isGraduated = false;

  void submitData() {
    final index = widget.id;

    if (index == null) {
      if (widget.developerForm.currentState.validate()) {
        Box<Developer> todoBox = Hive.box<Developer>('developers');
        todoBox.add(
            Developer(nome: nome, isGraduated: isGraduated, choices: choices));
        Navigator.of(context).pop();
      }
    } else {
      if (widget.developerForm.currentState.validate()) {
        final index = widget.id;
        Developer developer =
            Developer(nome: nome, isGraduated: isGraduated, choices: choices);
        Box<Developer> todoBox = Hive.box<Developer>('developers');
        todoBox.putAt(index, developer);
        Navigator.of(context).pop();
      }
    }
  }

  List<Map<String, dynamic>> devLevel = [
    {"nome": "Junior"},
    {"nome": "Pleno"},
    {"nome": "Senior"},
  ];

  List<Map<String, dynamic>> devLevel2 = [
    {"nome": "Especialista"},
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      devLevel.addAll(devLevel2);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MyAppBar(
        title: widget.id == null ? "Create Developer" : widget.nomeChange,
        actionsAppBar: Container(),
      ),
      body: Center(
        child: Container(
          width: size.width * 0.95,
          padding: EdgeInsets.all(5),
          child: Form(
              key: widget.developerForm,
              child: ListView(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  InputText(
                    nome: nome,
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Field can not be empty";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        nome = value;
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
                                  fontSize: 18, color: CustomColors.textColor),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              choices,
                              style: TextStyle(color: CustomColors.textColor),
                            ),
                          ),
                    dropdownItens: devLevel.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val["nome"],
                          child:
                              Container(width: 100, child: Text(val["nome"])),
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
                      activeColor: CustomColors.theme,
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
                      style:
                          ElevatedButton.styleFrom(primary: CustomColors.theme),
                      onPressed: submitData,
                      child: widget.id == null
                          ? Text("Create Developer")
                          : Text("Update Developer")),
                ],
              )),
        ),
      ),
    );
  }
}
