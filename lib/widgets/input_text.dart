import 'package:flutter/material.dart';
import 'package:flutter_hive/css/colors.dart';

class InputText extends StatefulWidget {
  String name;
  Function validator;
  Function onChanged;

  InputText({Key key, this.name, this.validator, this.onChanged})
      : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: widget.validator,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.theme)),
            hintStyle: const TextStyle(color: CustomColors.textInput),
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
            fillColor: CustomColors.textColor,
            filled: true,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.theme)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(color: CustomColors.theme)),
            prefixIcon: const Icon(
              Icons.arrow_right,
              color: CustomColors.theme,
              size: 30.0,
            ),
            labelText: "Name",
            labelStyle: TextStyle(color: CustomColors.theme)),
        onChanged: widget.onChanged);
  }
}
