import 'package:flutter/material.dart';
import 'package:flutter_hive/model/todo_model.dart';
import 'package:hive/hive.dart';

class AddTodo extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String title;
  String _dropDownValue;
  bool isCompleted = false;

  submitData() async {
    if (widget.formkey.currentState.validate()) {
      Box<TodoModel> todoBox = Hive.box<TodoModel>('todo2');
      todoBox.add(TodoModel(
          title: title, isCompleted: isCompleted, choices: _dropDownValue));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add todo", style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: Form(
          key: widget.formkey,
          child: ListView(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Checkbox(
                  value: isCompleted,
                  activeColor: Colors.orange,
                  onChanged: (bool valor) {
                    setState(() {
                      isCompleted = valor;
                    });
                    print("Checkbox: " + valor.toString());
                  },
                ),
                Text(
                  'Solicitar Retirada do GDM',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ]),
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
                decoration: InputDecoration(hintText: 'Add title'),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: _dropDownValue == null
                          ? Text(
                              'Selecione o motivo',
                              style: TextStyle(fontSize: 20),
                            )
                          : Text(
                              _dropDownValue,
                              style: TextStyle(color: Colors.blue),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      items: ['Gdm 1', 'Gdm 2', 'Gdm 3'].map(
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
                            _dropDownValue = val;
                          },
                        );
                      },
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(onPressed: submitData, child: Text('Submit Data')),
            ],
          )),
    );
  }
}
