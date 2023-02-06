
import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuerySize.heigthSize(context) * 0.85,
      width: MediaQuerySize.widthSize(context),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 50,
            ),
            Text(
              "No note avaliable",
              style: TextStyle(color: Colors.grey.shade400),
            )
          ]),
    );
  }
}
