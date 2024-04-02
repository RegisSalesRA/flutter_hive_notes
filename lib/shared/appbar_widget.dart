import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? automaticallyImplyLeading;
  final Widget? widgetAction;
  const AppBarWidget(
      {super.key,
      this.title,
      this.automaticallyImplyLeading,
      this.widgetAction});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.grey.shade400,
      automaticallyImplyLeading: automaticallyImplyLeading!,
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        title!,
        style: Theme.of(context).textTheme.displayLarge,
      ),
      actions: [widgetAction!],
    );
  }
}
