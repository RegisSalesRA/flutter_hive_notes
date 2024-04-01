import 'package:flutter/material.dart';

import '../config/config.dart';

class ToogleWidget extends StatelessWidget {
  const ToogleWidget({
    super.key,
    required this.notificationSchedule,
    required this.onTap1,
    required this.onTap2,
  });

  final bool notificationSchedule;
  final void Function()? onTap1;
  final void Function()? onTap2;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
        onTap: onTap1,
        child: Container(
            height: 50,
            width: 140,
            decoration: BoxDecoration(
                color: notificationSchedule == true
                    ? ColorsTheme.primaryColor
                    : Colors.grey.shade400,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: const Center(
                child: Text(
              "Sim",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ))),
      ),
      InkWell(
        onTap: onTap2,
        child: Container(
            height: 50,
            width: 140,
            decoration: BoxDecoration(
                color: notificationSchedule == false
                    ? ColorsTheme.primaryColor
                    : Colors.grey.shade400,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: const Center(
                child: Text(
              "Nao",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ))),
      ),
    ]);
  }
}
