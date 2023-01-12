import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String? name;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  InputText({Key? key, this.name, required this.validator, this.onChanged})
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
          prefixIcon: const Icon(
            Icons.app_registration,
            size: 25.0,
          ),
          labelText: "Name",
        ),
        maxLength: 25,
        onChanged: widget.onChanged);
  }
}
