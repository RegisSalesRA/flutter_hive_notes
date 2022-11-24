import 'package:flutter/material.dart';
import '../config/colors.dart';

class InputText extends StatefulWidget {
 final String name;
  final Function validator;
  final Function onChanged;

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
          focusedBorder: OutlineInputBorder(),
          hintStyle: const TextStyle(color: ColorsTheme.textInput),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          fillColor: ColorsTheme.textColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          prefixIcon: const Icon(
            Icons.arrow_right,
            size: 30.0,
          ),
          labelText: "Name",
        ),
        onChanged: widget.onChanged);
  }
}
