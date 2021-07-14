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
  //TodoFilter filter = TodoFilter.ALL;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.box('todo');
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
          valueListenable: Hive.box<TodoModel>('todo').listenable(),
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
                  return ListTile(
                    onLongPress: () async {
                      await box.deleteAt(index);
                    },
                    title: Text(
                      todo.title,
                      style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                    ),
                    subtitle: Text(
                      todo.detail,
                      style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
