import 'package:flutter/material.dart';

import '../../config/theme/theme.dart';

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
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sort by",
                    style: Theme.of(context).textTheme.displaySmall,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: filterValueComplete == 1
                                ? ColorsThemeLight.primaryColor
                                : Colors.grey.shade400,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Home notes",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: onTap2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: filterValueComplete == 2
                                ? ColorsThemeLight.primaryColor
                                : Colors.grey.shade400,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.work_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Job notes",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: onTap3,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: filterValueComplete == 3
                                ? ColorsThemeLight.primaryColor
                                : Colors.grey.shade400,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.assignment_late_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Urgency notes",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
      );
    },
  );
}
