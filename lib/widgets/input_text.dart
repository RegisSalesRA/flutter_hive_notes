import 'package:flutter/material.dart';

import '../config/theme/theme.dart';

class InputText extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? title;
  final int? maxLines;
  final TextEditingController controller;
  final int? characters;
  final Function(String?)? onChanged;

  const InputText(
      {super.key,
      required this.validator,
      required this.title,
      required this.maxLines,
      this.onChanged,
      required this.characters,
      required this.controller});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: widget.characters,
        maxLines: widget.maxLines,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.app_registration,
            size: 25.0,
          ),
          labelStyle: const TextStyle(color: ColorsThemeLight.textColor),
          labelText: widget.title,
        ),
        onChanged: widget.onChanged);
  }
}
