import 'package:flutter/material.dart';

import '../../config/config.dart';

Future<void> showModalBottonSheetWidget(
    BuildContext context,
    void Function() onTap,
    void Function() onTap2,
    void Function() onTap3,
    int filterValueComplete) {
  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 250,
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sort by",
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: filterValueComplete == 1
                                ? ColorsTheme.primaryColor
                                : Colors.grey.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Home notes",
                                style: Theme.of(context).textTheme.headline4,
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: onTap2,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: filterValueComplete == 2
                                ? ColorsTheme.primaryColor
                                : Colors.grey.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.work_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Job notes",
                                style: Theme.of(context).textTheme.headline4,
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: onTap3,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: filterValueComplete == 3
                                ? ColorsTheme.primaryColor
                                : Colors.grey.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.assignment_late_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Urgency notes",
                                style: Theme.of(context).textTheme.headline4,
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox()
            ],
          ),
        ),
      );
    },
  );
}
