import 'package:flutter/material.dart';

class RickTextChart extends StatelessWidget {
  const RickTextChart({
    Key? key,
    required this.keys,
    required this.urgency,
    required this.title,
    required this.color,
  }) : super(key: key);

  final List<int>? keys;
  final String urgency;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0),
              ),
            ],
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: urgency,
                style: TextStyle(
                    color: color, fontSize: 20, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: title,
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: keys!.length.toString(),
                      style: TextStyle(
                          color: color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ));
  }
}
