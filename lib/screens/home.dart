import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/css/colors.dart';
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
  List<Developer> dev = [];

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

  void searchFunction(valorInputSearch) {
    if (_serachController.text.isEmpty || _serachController.text == "") {
      print("");
    }

    setState(() {
      dev = [];
    });
    for (var iten in boxform.value.values) {
      if (iten.nome.startsWith(valorInputSearch)) {
        print(iten.nome);

        setState(() {
          dev.add(iten);
        });
      }
    }
    print("Lista filtrada de ${dev}");
  }

  @override
  void dispose() {
    super.dispose();
    _serachController;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.theme,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DeveloperCreate()),
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF00BCD4),
          title: Text("Hive Developers"),
          centerTitle: true,
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      dev.clear();
                    });
                  },
                  child: Icon(Icons.refresh),
                ),
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
                ),
              ],
            )
          ],
        ),
        body: dev.length != 0
            ? ValueListenableBuilder(
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
                              style: const TextStyle(
                                  color: CustomColors.textInput),
                              onSubmitted: (valorInputSearch) {
                                searchFunction(valorInputSearch);
                              },
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                    color: CustomColors.textInput),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: CustomColors.theme)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                    borderSide: const BorderSide(
                                        color: CustomColors.theme)),
                                hintText: 'Search dev pesquisados',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: CustomColors.theme,
                                  size: 30.0,
                                ),
                              ))),
                      Expanded(
                          child: ListView.builder(
                              itemCount: dev.length,
                              itemBuilder: (context, index) {
                                return DeveloperWidget(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeveloperUpdate(
                                                  id: index,
                                                  nomeChange: dev[index].nome,
                                                )));
                                  },
                                  onLongPress: () async {
                                    final devElement = box.values.firstWhere(
                                        (element) =>
                                            element.nome == dev[index].nome);
                                    await devElement.delete();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  },
                                  icon: Icon(
                                    dev[index].isGraduated
                                        ? Icons.school
                                        : Icons.person,
                                    color: CustomColors.textColor,
                                  ),
                                  text: dev[index].nome ?? "default",
                                  subtitle: dev[index].choices == null
                                      ? Text("Unknow")
                                      : Text(dev[index].choices),
                                );
                              }))
                    ],
                  );
                })
            : ValueListenableBuilder(
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
                      Container(
                          width: size.width * 0.95,
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                              style: const TextStyle(
                                  color: CustomColors.textInput),
                              onSubmitted: (valorInputSearch) {
                                searchFunction(valorInputSearch);
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: CustomColors.theme)),
                                hintStyle: const TextStyle(
                                    color: CustomColors.textInput),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                fillColor: CustomColors.textColor,
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: CustomColors.theme)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                    borderSide: const BorderSide(
                                        color: CustomColors.theme)),
                                hintText: 'Search dev',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: CustomColors.theme,
                                  size: 30.0,
                                ),
                              ))),
                      Container(
                        width: size.width * 0.99,
                        child: Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: box.length,
                                itemBuilder: (context, index) {
                                  Developer dev = box.getAt(index);

                                  return DeveloperWidget(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DeveloperUpdate(
                                                      id: index,
                                                      nomeChange: dev.nome,
                                                    )));
                                      },
                                      onLongPress: () async {
                                        await box.deleteAt(index);
                                      },
                                      icon: Icon(
                                        dev.isGraduated
                                            ? Icons.school
                                            : Icons.person,
                                        color: CustomColors.textColor,
                                      ),
                                      text: dev.nome ?? "default",
                                      subtitle: dev.choices == null
                                          ? Text(
                                              "Unknow",
                                              style: TextStyle(
                                                  color:
                                                      CustomColors.textColor),
                                            )
                                          : Text(
                                              dev.choices,
                                              style: TextStyle(
                                                  color:
                                                      CustomColors.textColor),
                                            ));
                                })),
                      )
                    ],
                  );
                },
              ));
  }
}
