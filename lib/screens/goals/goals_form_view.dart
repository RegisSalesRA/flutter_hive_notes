import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:math';

import '../../config/theme/theme.dart';
import '../../helpers/helpers.dart';
import '../../models/goals.dart';
import '../../widgets/widget.dart';

class GoalsFormView extends StatefulWidget {
  const GoalsFormView({
    super.key,
  });
  @override
  GoalsFormViewState createState() => GoalsFormViewState();
}

class GoalsFormViewState extends State<GoalsFormView> {
  Box<Goals> goalsBox = Hive.box<Goals>('goals');

  final goalsFormViewKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDetail = TextEditingController();
  TextEditingController controllerCategory = TextEditingController();
  String name = "";
  bool? done = false;
  List<Metas> objectives = [];

  void addObjective(int count) {
    for (int i = 0; i < count; i++) {
      objectives.add(Metas(
        id: Random.secure().nextInt(10000 - 1000) + 1000,
        name: controllerName.text,
        done: done,
        controller: TextEditingController(),
      ));
    }
    setState(() {});
  }

  void deleteObjetive() {
    objectives.removeLast();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          leading: IconButton(
            color: Colors.grey.shade400,
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          widgetAction: const SizedBox(),
          automaticallyImplyLeading: true,
          title: "Create goals",
        ),
        body: Center(
          child: Container(
            width: MediaQuerySize.widthSize(context) * 0.95,
            height: MediaQuerySize.heigthSize(context) * 0.95,
            padding: const EdgeInsets.all(5),
            child: Form(
                key: goalsFormViewKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    InputText(
                      title: "Title",
                      characters: 30,
                      maxLines: 1,
                      controller: controllerName,
                      validator: (value) {
                        if (controllerName.text.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value!;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text('Create objective:'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete_forever),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Remove Objective',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                deleteObjetive();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Remove',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        int itemCount = 1;
                                        return AlertDialog(
                                          title: Text(
                                            'Number of Objectives',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          content: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.app_registration,
                                                  size: 25.0,
                                                ),
                                                labelStyle: const TextStyle(
                                                    color: ColorsThemeLight
                                                        .textColor),
                                                labelText: "Select quantity",
                                              ),
                                              onChanged: (value) {
                                                itemCount =
                                                    int.tryParse(value) ?? 1;
                                              }),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                addObjective(itemCount);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Add',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: objectives.map((objective) {
                              return ListTile(
                                title: Text(objective.name!),
                                subtitle: TextField(
                                  controller: objective.controller,
                                  decoration: InputDecoration(
                                      labelText: 'Objetive step'),
                                ),
                              );
                            }).toList(),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              for (var objective in objectives) {
                                print(
                                    'Objective: ${objective.name}, Details: ${objective.controller}');
                              }
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () async {
                          if (goalsFormViewKey.currentState!.validate()) {
                            Goals goals = Goals(
                                createdAt: DateTime.now(),
                                isComplete: false,
                                name: controllerName.text,
                                metas: []);
                            await goalsBox.add(goals);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "Create goals",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
