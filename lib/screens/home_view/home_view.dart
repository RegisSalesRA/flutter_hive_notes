import 'package:flutter/material.dart';

import '../../routes/routes.dart';
import '../../widgets/container_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Goals && Notes"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(Routes.notes),
                  child: const ContainerWidget(
                    title: "Goals",
                    icon: 'assets/images/icons/objetivo.png',
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(Routes.notes),
                  child: const ContainerWidget(
                    title: "Notes",
                    icon: 'assets/images/icons/taxa.png',
                  ),
                ),
              ],
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
