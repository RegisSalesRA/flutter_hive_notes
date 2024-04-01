import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  final Widget? checkedIten;
  const CheckBoxWidget({super.key, this.checkedIten});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Text(
          'Graduated?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        widget.checkedIten!
      ]),
    );
  }
}
