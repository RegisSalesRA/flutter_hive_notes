import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/goals/goals_form_view.dart';
import 'package:flutter_hive/screens/goals/widgets/goals_complete_widget.dart';
import '../../models/goals.dart';
import 'package:flutter/foundation.dart';
import '../../routes/routes.dart';
import '../../widgets/popup_menu_button_goals_widget.dart';
import '../../widgets/widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'widgets/goals_incomplete_widgets.dart';

class GoalsView extends StatefulWidget {
  const GoalsView({super.key});

  @override
  State<GoalsView> createState() => _GoalsViewState();
}

class _GoalsViewState extends State<GoalsView> {
  String search = "";
  int filterValue = 0;
  TextEditingController controllerText = TextEditingController();

  ValueListenable<Box<Goals>> boxform = Hive.box<Goals>('goals').listenable();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const GoalsFormView()));

            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBarWidget(
          automaticallyImplyLeading: false,
          title: "Goals view",
          widgetAction: PopupMenuButtonGoalsWidget(
            onSelected: (value) {
              setState(() {
                filterValue = value;
                search = "";
                controllerText.clear();
              });
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
          leading: IconButton(
            color: Colors.grey.shade400,
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, Routes.initial, (route) => false),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                if (filterValue == 0)
                  GoalsIncomplete(
                    boxform: boxform,
                    textController: controllerText,
                    search: search,
                    onChanged: (value) {
                      setState(() {
                        search = value.toLowerCase();
                      });
                    },
                  ),
                if (filterValue == 1)
                  GoalsComplete(
                    boxform: boxform,
                    textController: controllerText,
                    search: search,
                    onChanged: (value) {
                      setState(() {
                        search = value.toLowerCase();
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomAppBarWidget(
          widgets: [],
        ),
      ),
    );
  }
}
