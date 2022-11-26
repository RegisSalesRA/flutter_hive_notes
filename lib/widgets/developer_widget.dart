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
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade400)
              /*
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0),
              )
            ],
        */
              ),
          child: ListTile(
              onTap: onTap,
              onLongPress: onLongPress,
              trailing: icon,
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              subtitle: subtitle)),
    );
  }
}
