import 'package:flutter/material.dart';
import 'package:flutter_hive/css/colors.dart';

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
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(8.0),
              color: CustomColors.theme,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0),
                )
              ],
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
