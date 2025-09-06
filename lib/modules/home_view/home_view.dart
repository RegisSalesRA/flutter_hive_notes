import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Goals && Notes",
            style: TextStyle(fontSize: 24, color: Colors.grey.shade400),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Column(
            children: [
              SizedBox(
                height: 24,
              ),
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

/**
 *       Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(Routes.goals),
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
 */
