 import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../helpers/helpers.dart';

List<PieChartSectionData> showingSections(touchedIndex,keysHome, keysComplete,keysJob,keysUrgency) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: percentageCalc(keysHome!.length, keysComplete!.length),
            title:
                '${percentageCalc(keysHome!.length, keysComplete!.length.toInt()).toInt()}%',
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
            value: percentageCalc(keysJob!.length, keysComplete!.length),
            title:
                '${percentageCalc(keysJob!.length, keysComplete!.length).toInt()}%',
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
            value: percentageCalc(keysUrgency!.length, keysComplete!.length),
            title:
                '${percentageCalc(keysUrgency!.length, keysComplete!.length).toInt()}%',
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