import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../animation/animation.dart';
import '../../../models/goals.dart';
import '../../../services/hive/goals_hive_service.dart';
import '../../../widgets/empty_list_widget.dart';
import 'package:hive/hive.dart';

class GoalsComplete extends StatefulWidget {
  final ValueListenable<Box<Goals>> boxform;
  final String search;
  final TextEditingController textController;
  final void Function(String) onChanged;
  const GoalsComplete(
      {super.key,
      required this.boxform,
      required this.search,
      required this.onChanged,
      required this.textController});

  @override
  State<GoalsComplete> createState() => _GoalsCompleteState();
}

class _GoalsCompleteState extends State<GoalsComplete> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.boxform,
      builder: (context, Box<Goals> box, _) {
        List<int> keys = box.keys
            .cast<int>()
            .where((key) => box.get(key)!.isComplete == true)
            .toList();
        List<int> keysSort = keys.reversed.toList();

        if (keys.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                    controller: widget.textController,
                    onChanged: widget.onChanged,
                    decoration: const InputDecoration(
                      hintText: 'Search goals',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30.0,
                      ),
                    )),
              ),
              SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  "Drag the card to the left to delete",
                  style: TextStyle(
                      color: Colors.grey.shade400, fontWeight: FontWeight.bold),
                )),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: keysSort.length,
                  itemBuilder: (context, index) {
                    int key = keysSort[index];
                    Goals? goals = box.get(key);
                    if (goals!.name
                        .toString()
                        .toLowerCase()
                        .contains(widget.search)) {
                      return AnimatedSlideText(
                        direction: 1,
                        child: Dismissible(
                            direction: DismissDirection.endToStart,
                            key: Key(goals.key.toString()),
                            background: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  )),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Delete",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(Icons.delete)
                                        ],
                                      ))),
                            ),
                            onDismissed: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                GoalsService.deletegoals(key);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: Material(
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.transparent,
                                                blurRadius: 2.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(2.0, 2.0),
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey.shade400)),
                                        child: ExpansionTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              goals.name,
                                            ),
                                          ),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          tilePadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          children: <Widget>[
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: goals.metas.length,
                                              itemBuilder: (context, index) =>
                                                  Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    goals.metas[index]
                                                        .description,
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  Checkbox(
                                                    value:
                                                        goals.metas[index].done,
                                                    onChanged:
                                                        (bool? newValue) {
                                                      setState(() {
                                                        goals.metas[index]
                                                            .done = newValue!;
                                                      });
                                                      GoalsService.updategoals(
                                                          key, goals);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      );
                    } else {
                      return const SizedBox();
                    }
                  })
            ],
          );
        } else {
          return const EmptyListWidget();
        }
      },
    );
  }
}
