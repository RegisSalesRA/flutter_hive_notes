import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  Widget checkedIten;
  CheckBoxWidget({Key key,this.checkedIten}) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Press if developer is graduated?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
       widget.checkedIten
      ]),
    );
  }
}
