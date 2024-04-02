import 'package:flutter/material.dart';

import '../../config/theme/theme.dart';
 

class PopupMenuButtonWidget extends StatelessWidget {
  final void Function(int) onSelected;
  const PopupMenuButtonWidget({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconSize: 30,
        icon: const Icon(
          Icons.more_vert,
          color: ColorsThemeLight.primaryColor,
        ),
        onSelected: onSelected,
        itemBuilder: (BuildContext bc) {
          return [
            const PopupMenuItem(
              value: 1,
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
            ),
            const PopupMenuItem(
              value: 2,
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
            ),
            const PopupMenuItem(
              value: 3,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_late_outlined,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Urgency notes")
                  ]),
            )
          ];
        });
  }
}
