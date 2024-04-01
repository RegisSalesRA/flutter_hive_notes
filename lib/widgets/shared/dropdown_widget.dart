import 'package:flutter/material.dart';

import '../../config/theme/theme.dart';
 

class DropDownWidget extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<DropdownMenuItem<String>>? dropdownItens;
  final Widget? hint;

  const DropDownWidget(
      {Key? key,
      this.onChanged,
      required this.dropdownItens,
      this.hint,
      required this.validator})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<String>(
          validator: widget.validator,
          isDense: true,
          hint: widget.hint,
          elevation: 16,
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          style: const TextStyle(
            color: ColorsThemeLight.primaryColor,
          ),
          onSaved: widget.onChanged,
          items: widget.dropdownItens,
          onChanged: widget.onChanged),
    ));
  }
}
