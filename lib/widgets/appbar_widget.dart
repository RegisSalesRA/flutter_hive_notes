import 'package:flutter/material.dart';

import '../css/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  Widget actionsAppBar;

  MyAppBar({Key key, this.title, this.actionsAppBar}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.theme,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: CustomColors.textColor,
        ),
      ),
      actions: [actionsAppBar],
    );
  }
}
