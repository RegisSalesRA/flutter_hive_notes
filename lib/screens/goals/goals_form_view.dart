import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';
import '../../widgets/widget.dart';

class GoalsFormView extends StatefulWidget {
  const GoalsFormView({
    super.key,
  });
  @override
  GoalsFormViewState createState() => GoalsFormViewState();
}

class GoalsFormViewState extends State<GoalsFormView> {
  final goalsFormViewKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDetail = TextEditingController();
  TextEditingController controllerCategory = TextEditingController();
  String name = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          leading: IconButton(
            color: Colors.grey.shade400,
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          widgetAction: const SizedBox(),
          automaticallyImplyLeading: true,
          title: "Create goals",
        ),
        body: Center(
          child: Container(
            width: MediaQuerySize.widthSize(context) * 0.95,
            height: MediaQuerySize.heigthSize(context) * 0.95,
            padding: const EdgeInsets.all(5),
            child: Form(
                key: goalsFormViewKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    InputText(
                      title: "Title",
                      characters: 30,
                      maxLines: 1,
                      controller: controllerName,
                      validator: (value) {
                        if (controllerName.text.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value!;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          var atualDate = DateTime.now();

                          if (goalsFormViewKey.currentState!.validate()) {
                            if (1 == 1) {
                              //   Navigator.of(context).pushNamed(Routes.notes);
                              return;
                            } else {
                              snackBarWidget(context,
                                  'you need to choose a time above the current one');
                              return;
                            }
                          }
                        },
                        child: Text(
                          "Create goals",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
