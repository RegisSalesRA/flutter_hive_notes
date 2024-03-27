import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/config/colors.dart';
import 'package:flutter_hive/helpers/helpers.dart';
import 'package:flutter_hive/models/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/widget.dart';

class CompleteNotesChartScreen extends StatefulWidget {
  const CompleteNotesChartScreen({super.key});

  @override
  State<StatefulWidget> createState() => CompleteNotesChartScreenState();
}

class CompleteNotesChartScreenState extends State {
  int touchedIndex = -1;
  ValueListenable<Box<Note>> boxform = Hive.box<Note>('notes').listenable();
  List<int>? keysComplete;
  List<int>? keysIncomplete;
  List<int>? keysHome;
  List<int>? keysJob;
  List<int>? keysUrgency;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          automaticallyImplyLeading: true,
          title: "Graphic",
          widgetAction: SizedBox(),
        ),
        body: SizedBox(
          height: MediaQuerySize.heigthSize(context),
          child: ValueListenableBuilder(
              valueListenable: boxform,
              builder: (context, Box<Note> box, _) {
                if (boxform.value.isNotEmpty) {
                  keysComplete = box.keys
                      .cast<int>()
                      .where((key) => box.get(key)!.isComplete)
                      .toList();

                  keysIncomplete = box.keys
                      .cast<int>()
                      .where((key) => box.get(key)!.isComplete == false)
                      .toList();

                  keysHome = box.keys
                      .cast<int>()
                      .where((key) =>
                          box.get(key)!.urgency == "Home" &&
                          box.get(key)!.isComplete == true)
                      .toList();

                  keysJob = box.keys
                      .cast<int>()
                      .where((key) =>
                          box.get(key)!.urgency == "Job" &&
                          box.get(key)!.isComplete == true)
                      .toList();

                  keysUrgency = box.keys
                      .cast<int>()
                      .where((key) =>
                          box.get(key)!.urgency == "Urgency" &&
                          box.get(key)!.isComplete == true)
                      .toList();
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 350,
                        width: double.infinity,
                        child: Column(children: [
                          const SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Indicator(
                                  color: Colors.green,
                                  text: 'Home',
                                  isSquare: true,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Indicator(
                                  color: Colors.orange,
                                  text: 'Job',
                                  isSquare: true,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Indicator(
                                  color: Colors.red,
                                  text: 'Urgency',
                                  isSquare: true,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  },
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 5,
                                centerSpaceRadius: 80,
                                sections: showingSections(
                                    touchedIndex,
                                    keysHome,
                                    keysComplete,
                                    keysJob,
                                    keysUrgency),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              RickTextChart(
                                keys: keysIncomplete,
                                color: ColorsTheme.primaryColor,
                                urgency: 'Uncompleted ',
                                title: 'notes - ',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RickTextChart(
                                keys: keysHome,
                                color: Colors.green,
                                urgency: 'Home ',
                                title: 'notes completed - ',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RickTextChart(
                                keys: keysJob,
                                color: Colors.orange,
                                urgency: 'Job ',
                                title: 'notes completed - ',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RickTextChart(
                                keys: keysUrgency,
                                color: Colors.red,
                                urgency: 'Urgency ',
                                title: 'notes completed - ',
                              ),
                            ]),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
