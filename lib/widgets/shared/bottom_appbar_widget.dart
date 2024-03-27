import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  final List<Widget>? widgets;
  const BottomAppBarWidget({Key? key, this.widgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.primary,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [...widgets!],
        ),
      ),
    );
  }
}
