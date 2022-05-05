import 'package:flutter/material.dart';
import 'package:flutter_hive/model/developer.dart';
import 'package:hive/hive.dart';

class CreateForm extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  @override
  _CreateFormState createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  String nome;
  String choices;
  bool isGraduated = false;

  submitData() async {
    if (widget.formkey.currentState.validate()) {
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
        title: Text("Form", style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: Form(
          key: widget.formkey,
          child: Container(
              padding: EdgeInsets.all(15),
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
                    decoration: InputDecoration(hintText: 'Title'),
                    onChanged: (value) {
                      setState(() {
                        nome = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: choices == null
                              ? Text(
                                  'Selecione a opção',
                                  style: TextStyle(fontSize: 20),
                                )
                              : Text(
                                  choices,
                                  style: TextStyle(color: Colors.blue),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          items: ['Masculino', 'Feminino'].map(
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Checkbox(
                      value: isGraduated,
                      activeColor: Colors.orange,
                      onChanged: (bool valor) {
                        setState(() {
                          isGraduated = valor;
                        });
                        print("Checkbox: " + valor.toString());
                      },
                    ),
                    Text(
                      'is completed?',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  SizedBox(
                    height: 55,
                  ),
                  ElevatedButton(
                      onPressed: submitData, child: Text('Submit Data')),
                ],
              ))),
    );
  }
}
