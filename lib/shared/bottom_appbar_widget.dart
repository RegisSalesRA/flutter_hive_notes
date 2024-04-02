import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  final List<Widget>? widgets;
  const BottomAppBarWidget({super.key, this.widgets});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [...widgets!],
          ),
        ),
      ),
    );
  }
}
