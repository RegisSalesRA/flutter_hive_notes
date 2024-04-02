import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? automaticallyImplyLeading;
  final Widget? widgetAction;
  final Widget? leading;
  const AppBarWidget(
      {super.key,
      this.title,
      this.automaticallyImplyLeading,
      this.leading,
      this.widgetAction});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading!,
      leading: leading,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title!,
      ),
      actions: [widgetAction!],
    );
  }
}
