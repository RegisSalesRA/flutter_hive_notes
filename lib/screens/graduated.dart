import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart'; 
import 'package:flutter_hive/widgets/developer_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'forms/form.dart';

class Graduated extends StatefulWidget {
  @override
  _GraduatedState createState() => _GraduatedState();
}

class _GraduatedState extends State<Graduated> {
  @override
  void initState() {
    super.initState();
  }

  var valueBox = Hive.box<Developer>('developers').listenable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FormDeveloper()),
          );
        },
      ),
      appBar: AppBar(
        title: Text("Hive Graduated"),
        centerTitle: true,
      ),
      body: Container(
        child: ValueListenableBuilder(
          valueListenable: valueBox,
          builder: (context, Box<Developer> box, _) {
            List<int> keys;

            keys = box.keys
                .cast<int>()
                .where((key) => box.get(key).isGraduated)
                .toList();

            if (box.values.isEmpty) {
              return Center(
                child: Text("No data available!",
                    style: TextStyle(fontFamily: 'Montserrat')),
              );
            }
            return ListView.builder(
                itemCount: keys.length,
                itemBuilder: (context, index) {
                  final int key = keys[index];
                  final Developer dev = box.get(key);

                  return DeveloperWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormDeveloper(
                                    id: index,
                                    nomeChange: dev.nome,
                                  )));
                    },
                    onLongPress: () async {
                      await box.deleteAt(index);
                    },
                    icon: Icon(
                      dev.isGraduated
                         ? Icons.school : Icons.person,
                      color: Colors.blue,
                    ),
                    text: dev.nome ?? "default",
                    subtitle: dev.choices == null
                        ? Text("Unknow")
                        : Text(dev.choices),
                  );
                });
          },
        ),
      ),
    );
  }
}
