import 'package:flutter/material.dart';
import 'package:flutter_hive/css/colors.dart';

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
        color: CustomColors.theme,
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
              hint: widget.hint,
              elevation: 16,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: CustomColors.textColor,
              ),
              style: TextStyle(
                color: CustomColors.textInput,
              ),
              items: widget.dropdownItens,
              onChanged: widget.onChanged),
        )));
  }
}
