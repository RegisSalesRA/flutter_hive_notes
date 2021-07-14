import 'package:flutter/material.dart';
import 'package:flutter_hive/model/todo_model.dart';
import 'package:hive/hive.dart';

class AddTodo extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String title, detail;

  submitData() async {
    if (widget.formkey.currentState.validate()) {
      Box<TodoModel> todoBox = Hive.box<TodoModel>('todo');
      todoBox.add(TodoModel(title: title, detail: detail));
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
              TextFormField(
                decoration: InputDecoration(hintText: 'Add title'),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Add description'),
                onChanged: (value) {
                  setState(() {
                    detail = value;
                  });
                },
              ),
              ElevatedButton(onPressed: submitData, child: Text('Submit Data'))
            ],
          )),
    );
  }
}
