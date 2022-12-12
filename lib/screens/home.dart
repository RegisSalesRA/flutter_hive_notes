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
  ValueListenable<Box<Developer>> boxform =
      Hive.box<Developer>('developers').listenable();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TaskForm()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: AppBarWidget(
            title: "Flutter Hive",
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                TaskListWidget(
                  boxform: boxform,
                  size: size,
                  search: search,
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                
                )
              ]),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).colorScheme.primary,
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(),
                  IconButton(
                    icon: Icon(
                      Icons.timeline,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
