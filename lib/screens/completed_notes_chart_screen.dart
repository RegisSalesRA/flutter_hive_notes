import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
        body: SizedBox(
          height: MediaQuerySize.heigthSize(context),
          width: MediaQuerySize.widthSize(context),
          child: Stack(children: [
            ValueListenableBuilder(
                valueListenable: boxform,
                builder: (context, Box<Note> box, _) {
                  if (boxform.value.isNotEmpty) {
                    keysComplete = box.keys
                        .cast<int>()
                        .where((key) => box.get(key).isComplete)
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

                  print(keysComplete);
                  print(keysHome);
                  print(keysJob);
                  print(keysUrgency);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(),
                      SizedBox(),
                      SizedBox(
                        height: MediaQuerySize.heigthSize(context) * 0.30,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
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
                            centerSpaceRadius: 110,
                            sections: showingSections(),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuerySize.heigthSize(context) * 0.40,
                        width: MediaQuerySize.widthSize(context),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    height: 75,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0, 2.0),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                                  text: 'notes quantity - ',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade400,
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
                                Container(
                                    height: 75,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0, 2.0),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                                  text: 'notes quantity - ',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade400,
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
                                Container(
                                    height: 75,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0, 2.0),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                                  text: 'notes quantity - ',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade400,
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
                        ),
                      )
                    ],
                  );
                }),
            Positioned(
                top: MediaQuerySize.heigthSize(context) * 0.02,
                right: MediaQuerySize.heigthSize(context) * 0.02,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Indicator(
                      color: Colors.green,
                      text: 'Home',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.orange,
                      text: 'Job',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Colors.red,
                      text: 'Urgency',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                )),
          ]),
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
            value: percentageCalc(
                keysHome.length.toInt(), keysComplete.length.toInt()),
            title:
                '${percentageCalc(keysHome.length.toInt(), keysComplete.length.toInt()).toInt()}%',
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
            value: percentageCalc(
                keysJob.length.toInt(), keysComplete.length.toInt()),
            title:
                '${percentageCalc(keysJob.length.toInt(), keysComplete.length.toInt()).toInt()}%',
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
            value: percentageCalc(
                keysUrgency.length.toInt(), keysComplete.length.toInt()),
            title:
                '${percentageCalc(keysUrgency.length.toInt(), keysComplete.length.toInt()).toInt()}%',
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
