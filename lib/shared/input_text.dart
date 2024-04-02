import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Function(String?)? onChanged;

  const InputText(
      {super.key,
      required this.validator,
      this.onChanged,
      required this.controller});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: 255,
        controller: widget.controller,
        validator: widget.validator,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.app_registration,
            size: 25.0,
          ),
          labelText: "Name",
        ),
        onChanged: widget.onChanged);
  }
}
