import 'package:flutter/material.dart';
import 'package:flutter_hive/model/todo_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'add_todo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.box('todo2');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTodo()),
          );
        },
      ),
      appBar: AppBar(
        title: Text("Hive Todo"),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Container(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<TodoModel>('todo2').listenable(),
          builder: (context, Box<TodoModel> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Text("No data available!",
                    style: TextStyle(fontFamily: 'Montserrat')),
              );
            }
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  TodoModel todo = box.getAt(index);
                  print(todo.isCompleted);
                  return ListTile(
                    onLongPress: () async {
                      await box.deleteAt(index);
                    },
                    trailing: todo.choices == null
                        ? Text("Unknow")
                        : Text(todo.choices),
                    title: Text(
                      todo.title,
                      style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                    ),
                    subtitle: Icon(
                      todo.isCompleted ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
