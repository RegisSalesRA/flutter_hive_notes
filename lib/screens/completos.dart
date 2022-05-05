import 'package:flutter/material.dart';
import 'package:flutter_hive/model/form_model.dart';
import 'package:flutter_hive/screens/update_form.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'crate_form.dart';

class FormsCompleted extends StatefulWidget {
  @override
  _FormsCompletedState createState() => _FormsCompletedState();
}

class _FormsCompletedState extends State<FormsCompleted> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateForm()),
          );
        },
      ),
      appBar: AppBar(
        title: Text("Hive Form Completo"),
        centerTitle: true,
      ),
      body: Container(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<FormModel>('formData').listenable(),
          builder: (context, Box<FormModel> box, _) {
            var filterbox =
                box.values.where((element) => element.isCompleted == true);
            print(filterbox);

            if (box.values.isEmpty) {
              return Center(
                child: Text("No data available!",
                    style: TextStyle(fontFamily: 'Montserrat')),
              );
            }
            return ListView.builder(
                itemCount: filterbox.length,
                itemBuilder: (context, index) {
                  FormModel form = box.getAt(index);

                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateForm(
                                    id: index,
                                    nomeChange: form.nome,
                                  )));
                    },
                    onLongPress: () async {
                      await box.deleteAt(index);
                    },
                    trailing: Icon(
                      form.isCompleted
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Colors.blue,
                    ),
                    title: Text(
                      form.nome,
                      style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                    ),
                    subtitle: form.choices == null
                        ? Text("Unknow")
                        : Text(form.choices),
                  );
                });
          },
        ),
      ),
    );
  }
}
