import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../config/colors.dart';
import '../models/developer.dart';
import '../screens/forms/form.dart';
import 'alert_dialog_widget.dart';
import 'developer_widget.dart';

class DeveloperListWidget extends StatelessWidget {
  final ValueListenable<Box<Developer>> boxform;
  final Size size;
  final String search;
  final Function ontap;
  final Function longPress;
  final void Function(String) onChanged;

  const DeveloperListWidget(
      {Key key,
      this.boxform,
      this.size,
      this.search,
      this.onChanged,
      this.ontap,
      this.longPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxform,
      builder: (context, Box<Developer> box, _) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                  onChanged: onChanged,
                  style: const TextStyle(color: ColorsTheme.textInput),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: ColorsTheme.textInput),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: ColorsTheme.textColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Search developer',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                  )),
            ),
            
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: box.length,
                itemBuilder: (context, index) {
                  Developer dev = box.getAt(index);
                  return dev.name.toString().toLowerCase().contains(search)
                      ? DeveloperWidget(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormDeveloper(
                                          id: dev.key,
                                          nameChange: dev.name,
                                        )));
                          },
                          longPress: () async {
                            await showDialogWidget(context, dev, box);
                          },
                          icon: Icon(
                            dev.isGraduated ? Icons.school : Icons.person,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          text: dev.name ?? "default",
                          subtitle: dev.choices == null
                              ? Text(
                                  "Unknow",
                                  style: Theme.of(context).textTheme.headline3,
                                )
                              : Text(
                                  dev.choices,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                        )
                      : Container();
                })
          ],
        );
      },
    );
  }
}
