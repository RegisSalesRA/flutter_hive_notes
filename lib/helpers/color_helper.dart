import 'package:flutter/material.dart';

Widget colorHelperText(String note) {
  if (note == "Urgency")
    return Text(
      "$note - ",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
    );
  if (note == "Job")
    return Text(
      "$note - ",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
    );
  if (note == "Home")
    return Text(
      "$note - ",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
    );
  return Container();
}
