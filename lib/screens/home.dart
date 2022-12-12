import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/models/developer.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/widget.dart';
import 'forms/form.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String search = "";
  int indexValue = 0;
  ValueListenable<Box<Developer>> boxform =
      Hive.box<Developer>('developers').listenable();

  void onItemTapped(int index) {
    setState(() {
      indexValue = index;
      search = "";
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
                        FocusScope.of(context).unfocus();
                        setState(() {
                          search = "";
                        });
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
                  DeveloperListWidget(
                    boxform: boxform,
                    size: size,
                    search: search,
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                    longPress: () async {},
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
                icon: Icon(Icons.done),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cancel),
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
