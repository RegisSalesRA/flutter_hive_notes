import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../config/colors.dart';
import '../widgets/widget.dart';
import 'graduated.dart';
import 'forms/form.dart';
import 'not_graduated.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> menu = ["Developers graduated", "Developers not graduated"];
  String search = "";
  int indexValue = 0;
  ValueListenable<Box<Developer>> boxform =
      Hive.box<Developer>('developers').listenable();

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

  void onItemTapped(int index) {
    setState(() {
      indexValue = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBarWidget(
              title: "Hive Developers",
              actionsAppBar: Row(
                children: [
                  PopupMenuButton<String>(
                    onSelected: _menuOptions,
                    itemBuilder: (context) {
                      return menu.map((String item) {
                        return PopupMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    },
                  ),
                ],
              )),
          body: Column(children: [
            if (indexValue == 0) ...{
              ValueListenableBuilder(
                valueListenable: boxform,
                builder: (context, Box<Developer> box, _) {
                  if (box.values.isEmpty) {
                    return Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ));
                  }
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                            width: size.width * 0.95,
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    search = value;
                                  });
                                  print(value);
                                },
                                style: const TextStyle(
                                    color: ColorsTheme.textInput),
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                      color: ColorsTheme.textInput),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  fillColor: ColorsTheme.textColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  hintText: 'Search developer',
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    size: 30.0,
                                  ),
                                ))),
                        Container(
                          width: size.width * 0.99,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: box.length,
                              itemBuilder: (context, index) {
                                Developer dev = box.getAt(index);
                                print(dev);
                                return dev.name
                                        .toString()
                                        .toLowerCase()
                                        .contains(search)
                                    ? DeveloperWidget(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FormDeveloper(
                                                        id: dev.key,
                                                        nameChange: dev.name,
                                                      )));
                                        },
                                        onLongPress: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text('Dev'),
                                              content: Text(
                                                  'Deseja deletar ${dev.name}'),
                                              actions: <Widget>[
                                                Center(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await box
                                                              .delete(dev.key);

                                                          Navigator.pop(
                                                              context, 'OK');
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ])),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          dev.isGraduated
                                              ? Icons.school
                                              : Icons.person,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                        text: dev.name ?? "default",
                                        subtitle: dev.choices == null
                                            ? Text(
                                                "Unknow",
                                                style: TextStyle(
                                                    color:
                                                        ColorsTheme.textColor),
                                              )
                                            : Text(
                                                dev.choices,
                                                style: TextStyle(
                                                    color:
                                                        ColorsTheme.textColor),
                                              ))
                                    : Container();
                              }),
                        )
                      ],
                    ),
                  );
                },
              )
            } else if (indexValue == 1) ...{
              Text("2")
            } else if (indexValue == 2) ...{
              Text("3")
            } else if (indexValue == 3) ...{
              Text("4")
            }
          ]),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.app_registration),
                label: ' ',
              ),
            ],
            currentIndex: indexValue,
            onTap: onItemTapped,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey.shade400,
          )),
    );
  }
}
