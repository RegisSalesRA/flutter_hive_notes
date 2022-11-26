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
    final size = MediaQuery.of(context).size;
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
                        size: 30,
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
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    search = value;
                                  });
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
                                )),
                          ),
                          if (boxform.value.values.length == 0)
                            SizedBox(
                              height: size.height * 0.50,
                              child: Center(child: Text("No dev available!")),
                            ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: box.length,
                              itemBuilder: (context, index) {
                                Developer dev = box.getAt(index);
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
                                        onLongPress: () async {
                                          await showDialogWidget(
                                              context, dev, box);
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3,
                                              )
                                            : Text(
                                                dev.choices,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3,
                                              ))
                                    : Container();
                              })
                        ],
                      );
                    },
                  )
                } else if (indexValue == 1)
                  GraduatedWidget(boxform: boxform, size: size)
                else if (indexValue == 2) ...{
                  NoGraduatedWidget(boxform: boxform, size: size)
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
                icon: Icon(Icons.school),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
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
