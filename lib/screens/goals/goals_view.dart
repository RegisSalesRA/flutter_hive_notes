import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/goals/goals_form_view.dart';
import '../../animation/animation.dart';
import '../../models/goals.dart';
import 'package:flutter/foundation.dart';
import '../../routes/routes.dart';
import '../../widgets/widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GoalsView extends StatefulWidget {
  const GoalsView({super.key});

  @override
  State<GoalsView> createState() => _GoalsViewState();
}

class _GoalsViewState extends State<GoalsView> {
  String search = "";
  bool? _value = false;
  TextEditingController controllerText = TextEditingController();

  ValueListenable<Box<Goals>> boxform = Hive.box<Goals>('goals').listenable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const GoalsFormView()));

          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBarWidget(
        automaticallyImplyLeading: false,
        title: "Goals view",
        widgetAction: const SizedBox(),
        leading: IconButton(
          color: Colors.grey.shade400,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, Routes.initial, (route) => false),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                    controller: null,
                    onChanged: null,
                    decoration: InputDecoration(
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
                  "Drag the card to the right to mark it complete",
                  style: TextStyle(
                      color: Colors.grey.shade400, fontWeight: FontWeight.bold),
                )),
              ),
              ValueListenableBuilder(
                valueListenable: boxform,
                builder: (context, Box<Goals> box, _) {
                  List<int> keys = box.keys
                      .cast<int>()
                      .where((key) => box.get(key)!.isComplete == false)
                      .toList();
                  List<int> keysSort = keys.reversed.toList();

                  if (keys.isNotEmpty) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: keysSort.length,
                        itemBuilder: (context, index) {
                          int key = keysSort[index];
                          Goals? goals = box.get(key);
                          if (search
                              .toString()
                              .toLowerCase()
                              .contains(search)) {
                            return AnimatedSlideText(
                              direction: 1,
                              child: Dismissible(
                                  direction: DismissDirection.startToEnd,
                                  key: Key(goals!.key.toString()),
                                  background: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.update_sharp),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Complete",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ],
                                            ))),
                                  ),
                                  onDismissed: (direction) async {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      setState(() {
                                        //  note.isComplete = !note.isComplete;
                                      });
                                      //  NoteService.updateNoteChecked(key, note);
                                    }
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade400)),
                                              child: ExpansionTile(
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    goals.name,
                                                  ),
                                                ),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                tilePadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                children: <Widget>[
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        goals.metas.length,
                                                    itemBuilder:
                                                        (context, index) => Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          goals.metas[index]
                                                              .description,
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                        Checkbox(
                                                          value: goals
                                                              .metas[index]
                                                              .done,
                                                          onChanged:
                                                              (bool? newValue) {
                                                            setState(() {
                                                              goals.metas[index]
                                                                      .done =
                                                                  newValue!;
                                                            });
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
                        });
                  } else {
                    return const EmptyListWidget();
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(
        widgets: [
          IconButton(
            icon: const Icon(
              Icons.not_interested_sharp,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.notes);
            },
          ),
          const SizedBox(),
          IconButton(
            icon: const Icon(
              Icons.check,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.complete);
            },
          ),
        ],
      ),
    );
  }
}
