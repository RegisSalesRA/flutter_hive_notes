import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/config/colors.dart';
import 'package:flutter_hive/helpers/helpers.dart';
import 'package:flutter_hive/models/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/widget.dart';

class CompleteNotesChartScreen extends StatefulWidget {
  const CompleteNotesChartScreen();

  @override
  State<StatefulWidget> createState() => CompleteNotesChartScreenState();
}

class CompleteNotesChartScreenState extends State {
  int touchedIndex = -1;
  ValueListenable<Box<Note>> boxform = Hive.box<Note>('notes').listenable();
  List<int> keysComplete;
  List<int> keysUncompleted;
  List<int> keysHome;
  List<int> keysJob;
  List<int> keysUrgency;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          automaticallyImplyLeading: true,
          title: "Gráfico",
          widgetAction: SizedBox(),
        ),
        body: Container(
          height: MediaQuerySize.heigthSize(context),
          child: ValueListenableBuilder(
              valueListenable: boxform,
              builder: (context, Box<Note> box, _) {
                if (boxform.value.isNotEmpty) {
                  keysComplete = box.keys
                      .cast<int>()
                      .where((key) => box.get(key).isComplete)
                      .toList();

                  keysUncompleted = box.keys
                      .cast<int>()
                      .where((key) => box.get(key).isComplete == false)
                      .toList();

                  keysHome = box.keys
                      .cast<int>()
                      .where((key) =>
                          box.get(key).urgency == "Home" &&
                          box.get(key).isComplete == true)
                      .toList();

                  keysJob = box.keys
                      .cast<int>()
                      .where((key) =>
                          box.get(key).urgency == "Job" &&
                          box.get(key).isComplete == true)
                      .toList();

                  keysUrgency = box.keys
                      .cast<int>()
                      .where((key) =>
                          box.get(key).urgency == "Urgency" &&
                          box.get(key).isComplete == true)
                      .toList();
                }

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: Column(children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
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
                                          .touchedSection.touchedSectionIndex;
                                    });
                                  },
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 5,
                                centerSpaceRadius: 80,
                                sections: showingSections(),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  height: 75,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.transparent,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Uncompleted ',
                                          style: TextStyle(
                                              color: ColorsTheme.primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'notes - ',
                                                style: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: keysUncompleted.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color: ColorsTheme
                                                        .primaryColor,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 75,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.transparent,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Home ',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'notes completed - ',
                                                style: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    '${keysHome.length.toString()}',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 75,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.transparent,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Job ',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'notes completed - ',
                                                style: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    '${keysJob.length.toString()}',
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 75,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.transparent,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Urgency ',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'notes completed - ',
                                                style: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    '${keysUrgency.length.toString()}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
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

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: percentageCalc(keysHome.length, keysComplete.length),
            title:
                '${percentageCalc(keysHome.length, keysComplete.length.toInt()).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: percentageCalc(keysJob.length, keysComplete.length),
            title:
                '${percentageCalc(keysJob.length, keysComplete.length).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: percentageCalc(keysUrgency.length, keysComplete.length),
            title:
                '${percentageCalc(keysUrgency.length, keysComplete.length).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );

        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
