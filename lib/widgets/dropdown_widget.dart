import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  Function onChanged;
  List dropdownItens = [];
  Widget hint;

  DropDownWidget({Key key, this.onChanged, this.dropdownItens, this.hint})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              hint: widget.hint,
              isExpanded: true,
              style: TextStyle(
                color: Colors.black,
              ),
              items: widget.dropdownItens,
              onChanged: widget.onChanged),
        ));
  }
}
