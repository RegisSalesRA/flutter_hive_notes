import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:flutter_hive/screens/forms/update_developer.dart';
import 'package:flutter_hive/widgets/developer_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'graduated.dart';
import 'forms/create_developer.dart';
import 'not_graduated.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> Menu = ["Developers graduated", "Developers not graduated"];

  ValueListenable<Box<Developer>> boxform =
      Hive.box<Developer>('developers').listenable();
  final _serachController = TextEditingController();

  _menuOptions(String options) {
    switch (options) {
      case "Developers graduated":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Graduated()));
        break;

      case "Developers not graduated":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NotGraduated()));
        break;
    }
  }

  void searchFunction() {
    if (_serachController.text.isEmpty || _serachController.text == "") {
      print("Vazio");
    }
    print("Nao vazio");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _serachController;
    Hive.box('developers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DeveloperCreate()),
          );
        },
      ),
      appBar: AppBar(
        title: Text("Hive Developers"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _menuOptions,
            itemBuilder: (context) {
              return Menu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        child: ValueListenableBuilder(
          valueListenable: boxform,
          builder: (context, Box<Developer> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Text("No data available!",
                    style: TextStyle(fontFamily: 'Montserrat')),
              );
            }
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                        style: const TextStyle(color: Colors.black),
                        onSubmitted: (val) {
                          print(val);
                        },
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              borderSide: const BorderSide(color: Colors.blue)),
                          hintText: 'Search dev',
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 30.0,
                          ),
                        ))),
                Expanded(
                    child: ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          Developer dev = box.getAt(index);

                          return DeveloperWidget(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeveloperUpdate(
                                            id: index,
                                            nomeChange: dev.nome,
                                          )));
                            },
                            onLongPress: () async {
                              await box.deleteAt(index);
                            },
                            icon: Icon(
                              dev.isGraduated ? Icons.school : Icons.person,
                              color: Colors.blue,
                            ),
                            text: dev.nome ?? "default",
                            subtitle: dev.choices == null
                                ? Text("Unknow")
                                : Text(dev.choices),
                          );
                        }))
              ],
            );
          },
        ),
      ),
    );
  }
}
