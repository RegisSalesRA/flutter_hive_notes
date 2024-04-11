import 'package:flutter/material.dart';

class PopupMenuButtonGoalsWidget extends StatelessWidget {
  final void Function(int) onSelected;
  const PopupMenuButtonGoalsWidget({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconSize: 30,
        icon: Icon(
          Icons.more_vert,
          color: Colors.grey.shade400,
        ),
        onSelected: onSelected,
        itemBuilder: (BuildContext bc) {
          return [
            const PopupMenuItem(
              value: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.golf_course_sharp,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Incomplete")
                  ]),
            ),
            const PopupMenuItem(
              value: 1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.golf_course_sharp,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Complete")
                  ]),
            )
          ];
        });
  }
}
