import 'package:flutter/material.dart';

import '../widgets/widget.dart';

abstract class MediaQuerySize {
  static double heigthSize(context) {
    var heigthSize = MediaQuery.of(context).size.height -
        const AppBarWidget(
          widgetAction: SizedBox(),
          automaticallyImplyLeading: false,
          title: '',
        ).preferredSize.height -
        MediaQuery.of(context).padding.top;
    return heigthSize;
  }

  static double widthSize(context) {
    var widthSize = MediaQuery.of(context).size.width;
    return widthSize;
  }
}
