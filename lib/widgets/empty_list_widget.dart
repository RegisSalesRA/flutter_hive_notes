import 'package:flutter/material.dart';

import '../helpers/helpers.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuerySize.heigthSize(context) * 0.85,
      width: MediaQuerySize.widthSize(context),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment_outlined,
              size: 50,
            ),
            Text(
              "No avaliable list",
              style: TextStyle(color: Colors.grey.shade400),
            )
          ]),
    );
  }
}
