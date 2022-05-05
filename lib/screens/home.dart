import 'package:flutter/material.dart';
import 'package:flutter_hive/model/form_model.dart';
import 'package:flutter_hive/screens/update_form.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'completos.dart';
import 'crate_form.dart';
import 'incompletos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> itensMenu = ["Alunos Completos", "Alunos Incompletos"];

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Alunos Completos":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FormsCompleted()));
        break;

      case "Alunos Incompletos":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FormsIncomplete()));
        break;
    }
  }

  var boxform = Hive.box<FormModel>('formData').listenable();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.box('formData');
    super.dispose();
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
        title: Text("Hive Form"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        child: ValueListenableBuilder(
          valueListenable: boxform,
          builder: (context, Box<FormModel> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Text("No data available!",
                    style: TextStyle(fontFamily: 'Montserrat')),
              );
            }
            return ListView.builder(
                itemCount: box.length,
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
