import 'package:flutter/material.dart';
import 'package:flutter_hive/widgets/appbar_widget.dart';

import '../../routes/routes.dart';
import '../../widgets/bottom_appbar_widget.dart';

class GoalsView extends StatelessWidget {
  const GoalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          /**
               Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NoteForm(
                        noteObject: null,
                      )));
            */

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
        widgetAction: const SizedBox(),
        leading: IconButton(
          color: Colors.grey.shade400,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, Routes.initial, (route) => false),
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(
        widgets: [
          IconButton(
            icon: const Icon(
              Icons.not_interested_sharp,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.notes);
            },
          ),
          const SizedBox(),
          IconButton(
            icon: const Icon(
              Icons.check,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.complete);
            },
          ),
        ],
      ),
    );
  }
}
