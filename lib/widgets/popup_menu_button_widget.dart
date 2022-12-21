
import 'package:flutter/material.dart';

import '../config/config.dart';

class PopupMenuButtonWidget extends StatelessWidget {
  final void Function(int) onSelected;
  const PopupMenuButtonWidget({
    Key key,
    this.onSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconSize: 30,
        icon: Icon(
          Icons.more_vert,
          color: ColorsTheme.primaryColor,
        ),
        onSelected: onSelected,
        itemBuilder: (BuildContext bc) {
          return [
            PopupMenuItem(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Home notes")
                  ]),
              value: 1,
            ),
            PopupMenuItem(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work_outlined,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Job notes")
                  ]),
              value: 2,
            ),
            PopupMenuItem(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.crisis_alert_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Urgency notes")
                  ]),
              value: 3,
            )
          ];
        });
  }
}