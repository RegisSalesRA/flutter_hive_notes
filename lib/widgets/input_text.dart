import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  String nome;
  Function validator;
  Function onChanged;

  InputText({Key key, this.nome, this.validator,this.onChanged}) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      decoration: InputDecoration(
          hintText: 'nome', labelText: "Name", border: OutlineInputBorder()),
      onChanged: widget.onChanged 
    );
  }
}
