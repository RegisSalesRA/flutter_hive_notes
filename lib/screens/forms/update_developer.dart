import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:hive/hive.dart';

class DeveloperUpdate extends StatefulWidget {
  final int id;
  final String nomeChange;

  DeveloperUpdate({Key key, this.id, this.nomeChange}) : super(key: key);

  final formkey = GlobalKey<FormState>();
  @override
  _DeveloperUpdateState createState() => _DeveloperUpdateState();
}

class _DeveloperUpdateState extends State<DeveloperUpdate> {
  String nome;
  String choices;
  bool isGraduated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Developer Update",
            style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: Form(
          key: widget.formkey,
          child: Container(
              padding: EdgeInsets.all(15),
              child: ListView(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text('Developer ${widget.nomeChange} update'),
                  ),
                  SizedBox(
                    height: 15,
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
                    height: 55,
                  ),
                  ElevatedButton(
                    child: Text('Submit Data'),
                    onPressed: () {
                      if (widget.formkey.currentState.validate()) {
                        final index = widget.id;
                        Developer developer = Developer(
                            nome: nome,
                            isGraduated: isGraduated,
                            choices: choices);
                        Box<Developer> todoBox =
                            Hive.box<Developer>('developers');
                        todoBox.putAt(index, developer);

                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ))),
    );
  }
}
