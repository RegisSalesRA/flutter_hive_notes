import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:hive/hive.dart';

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
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return "Por favor preencher os dados";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: "Name",
                      border: OutlineInputBorder()),
                  onChanged: (value) {
                    setState(() {
                      nome = value;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    color: Colors.grey,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
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
                        isExpanded: true,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        items: ['Junior', 'Pleno', 'Senior'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
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
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Press if developer is graduated?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                          value: isGraduated,
                          activeColor: Colors.orange,
                          onChanged: (bool valor) {
                            setState(() {
                              isGraduated = valor;
                            });
                          },
                        ),
                      ]),
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
