import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../config/colors.dart';
import '../widgets/widget.dart';
import 'forms/form.dart';

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

  void onItemTapped(int index) {
    setState(() {
      indexValue = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBarWidget(
              title: "Flutter Hive",
              actionsAppBar: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        return Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FormDeveloper()));
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).iconTheme.color,
                      ))
                ],
              )),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
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
                      return Column(
                        children: [
                          TextField(
                              onChanged: (value) {
                                setState(() {
                                  search = value;
                                });
                                print(value);
                              },
                              style:
                                  const TextStyle(color: ColorsTheme.textInput),
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                    color: ColorsTheme.textInput),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
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
                              )),
                          ListView.builder(
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
                              })
                        ],
                      );
                    },
                  )
                } else if (indexValue == 1)
                  ValueListenableBuilder(
                    valueListenable: boxform,
                    builder: (context, Box<Developer> box, _) {
                      List<int> keys;

                      keys = box.keys
                          .cast<int>()
                          .where((key) => box.get(key).isGraduated)
                          .toList();

                      if (box.values.isEmpty) {
                        return Center(
                          child: Text("No graduated available!",
                              style: TextStyle(fontFamily: 'Montserrat')),
                        );
                      }
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
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
                                              nameChange: dev.name,
                                            )));
                              },
                              onLongPress: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Dev'),
                                    content: Text('Deseja deletar ${dev.name}'),
                                    actions: <Widget>[
                                      Center(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await box.delete(dev.key);

                                                Navigator.pop(context, 'OK');
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ])),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                dev.isGraduated ? Icons.school : Icons.person,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              text: dev.name ?? "default",
                              subtitle: dev.choices == null
                                  ? Text(
                                      "Unknow",
                                    )
                                  : Text(
                                      dev.choices,
                                    ),
                            );
                          });
                    },
                  )
                else if (indexValue == 2) ...{
                  ValueListenableBuilder(
                    valueListenable: boxform,
                    builder: (context, Box<Developer> box, _) {
                      List<int> keys;

                      keys = box.keys
                          .cast<int>()
                          .where((key) => box.get(key).isGraduated == false)
                          .toList();

                      if (box.values.isEmpty) {
                        return Center(
                          child: Text("No graduated available!",
                              style: TextStyle(fontFamily: 'Montserrat')),
                        );
                      }
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
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
                                              nameChange: dev.name,
                                            )));
                              },
                              onLongPress: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Dev'),
                                    content: Text('Deseja deletar ${dev.name}'),
                                    actions: <Widget>[
                                      Center(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await box.delete(dev.key);

                                                Navigator.pop(context, 'OK');
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ])),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                dev.isGraduated ? Icons.school : Icons.person,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              text: dev.name ?? "default",
                              subtitle: dev.choices == null
                                  ? Text(
                                      "Unknow",
                                    )
                                  : Text(
                                      dev.choices,
                                    ),
                            );
                          });
                    },
                  )
                }
              ]),
            ),
          ),
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
            ],
            currentIndex: indexValue,
            onTap: onItemTapped,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey.shade400,
          )),
    );
  }
}
