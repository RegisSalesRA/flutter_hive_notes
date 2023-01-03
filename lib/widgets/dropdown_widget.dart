import 'package:flutter/material.dart';

import '../config/colors.dart';

class DropDownWidget extends StatefulWidget {
  final Function onChanged;
  final List dropdownItens;
  final Widget hint;

  DropDownWidget({Key key, this.onChanged, this.dropdownItens, this.hint})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a information';
            }
            return null;
          },
          isDense: true,
          hint: widget.hint,
          elevation: 16,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
          ),
          style: TextStyle(
            color: ColorsTheme.textInput,
          ),
          items: widget.dropdownItens,
          onChanged: widget.onChanged),
    )));
  }
}
