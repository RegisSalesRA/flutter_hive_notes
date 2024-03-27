import 'package:flutter/material.dart';
import 'package:flutter_hive/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../helpers/datatime_helper.dart';
import '../../models/note.dart';
import '../../services/notification/notification_service.dart';
import '../widget.dart';

class UpdateNotebuttonWidget extends StatelessWidget {
  const UpdateNotebuttonWidget(
      {Key? key,
      required RestorableDateTime selectedDate,
      required TimeOfDay timeOfDay,
      required this.noteFormKey,
      required this.notificationSchedule,
      required this.controllerName,
      required this.dataRecive,
      required this.controllerCategory,
      required this.noteObject})
      : _selectedDate = selectedDate,
        _timeOfDay = timeOfDay,
        super(key: key);

  final RestorableDateTime _selectedDate;
  final TimeOfDay _timeOfDay;
  final GlobalKey<FormState> noteFormKey;
  final bool notificationSchedule;
  final TextEditingController controllerName;
  final TextEditingController controllerCategory;
  final Note? noteObject;
  final DateTime? dataRecive;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          var atualDate = DateTime.now();
          var dataChose =
              DateTime.parse(dataFormaterInput(_selectedDate, _timeOfDay));
          if (noteFormKey.currentState!.validate()) {
             if (notificationSchedule == false) {
              Note objectNote = Note(
                  id: noteObject!.id,
                  name: controllerName.text,
                  urgency: controllerCategory.text,
                  isComplete: false,
                  dateTime: DateTime.parse(
                      dataFormaterInputUpdate(dataRecive!, _timeOfDay)),
                  payload: Routes.initial,
                  createdAt: noteObject!.createdAt);
               Provider.of<NotificationService>(context, listen: false)
                  .updateNote(noteObject!.key, objectNote);
                Navigator.of(context).pushNamed(Routes.initial);
              return;
            }

            if (notificationSchedule == true && dataChose.isAfter(atualDate)) {
                Note objectNote = Note(
                  id: noteObject!.id,
                  name: controllerName.text,
                  urgency: controllerCategory.text,
                  isComplete: false,
                  dateTime: DateTime.parse(
                      dataFormaterInputUpdate(dataRecive!, _timeOfDay)),
                  payload: Routes.initial,
                  createdAt: noteObject!.createdAt);
               Provider.of<NotificationService>(context, listen: false)
                  .updateNote(noteObject!.key, objectNote);
              Navigator.of(context).pushNamed(Routes.initial);
              return;
            } else {
              snackBarWidget(
                  context, 'You need to choose a time above the current one');
            }
          }
        },
        child: Text(
          "Update note",
          style: Theme.of(context).textTheme.headlineMedium,
        ));
  }
}
