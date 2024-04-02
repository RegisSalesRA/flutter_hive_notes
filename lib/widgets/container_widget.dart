import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final String? icon;
  final String? title;
  const ContainerWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              icon!,
              height: 50,
            ),
            Center(
              child: Text(
                title!,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ]),
    );
  }
}
