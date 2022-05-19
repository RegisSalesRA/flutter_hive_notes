import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:flutter_hive/widgets/checkbox_widget.dart';
import 'package:hive/hive.dart';

import '../../widgets/dropdown_widget.dart';
import '../../widgets/input_text.dart';

class DeveloperCreate extends StatefulWidget {
  final developerForm = GlobalKey<FormState>();
  @override
  _DeveloperCreateState createState() => _DeveloperCreateState();
}

class _DeveloperCreateState extends State<DeveloperCreate> {
  String nome;
  String choices;
  bool isGraduated = false;

  Future submitData() async {
    if (widget.developerForm.currentState.validate()) {
      Box<Developer> todoBox = Hive.box<Developer>('developers');
      todoBox.add(
          Developer(nome: nome, isGraduated: isGraduated, choices: choices));
      Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Developer",
            style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
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
                      return "Por favor preencher os dados";
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
                            'Selecione a opção',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            choices,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                  dropdownItens: devLevel.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val["nome"],
                        child: Text(val["nome"]),
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
                    activeColor: Colors.orange,
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
                    onPressed: submitData, child: Text('Register Developer')),
              ],
            )),
      ),
    );
  }
}
