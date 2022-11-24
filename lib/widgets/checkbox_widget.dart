import 'package:flutter/material.dart';
 

class CheckBoxWidget extends StatefulWidget {
 final Widget checkedIten;
  CheckBoxWidget({Key key, this.checkedIten}) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          'Graduated?',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
           ),
        ),
        widget.checkedIten
      ]),
    );
  }
}
