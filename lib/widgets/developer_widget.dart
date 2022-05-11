import 'package:flutter/material.dart';

class DeveloperWidget extends StatelessWidget {
  final Function onTap;
  final Function onLongPress;
  final Widget icon;
  final String text;
  final Widget subtitle;

  const DeveloperWidget(
      {Key key,
      this.onTap,
      this.onLongPress,
      this.icon,
      this.text,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: ListTile(
                onTap: onTap,
                onLongPress: onLongPress,
                trailing: icon,
                title: Text(
                  text,
                  style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                ),
                subtitle: subtitle)));
  }
}
