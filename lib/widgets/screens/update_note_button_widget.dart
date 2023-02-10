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
        onPressed: () {
          var atualDate = DateTime.now();
          var dataChose =
              DateTime.parse(dataFormaterInput(_selectedDate, _timeOfDay));
          if (noteFormKey.currentState!.validate()) {
            print('Data - ${_selectedDate.value}');
            print('Hora - ${_timeOfDay.hour}:${_timeOfDay.minute}');
            if (notificationSchedule == false) {
              Note objectNote = Note(
                  name: controllerName.text,
                  urgency: controllerCategory.text,
                  isComplete: false,
                  dateTime: DateTime.parse(
                      dataFormaterInputUpdate(dataRecive!, _timeOfDay)),
                  payload: Routes.initial,
                  createdAt: noteObject!.createdAt);
              print(objectNote.dateTime);
              Provider.of<NotificationService>(context, listen: false)
                  .updateNote(noteObject!.key, objectNote);
              print(objectNote);
              Navigator.of(context).pushNamed(Routes.initial);
              return;
            }

            if (notificationSchedule == true && dataChose.isAfter(atualDate)) {
              print('Data - ${_selectedDate.value}');
              print('Hora - ${_timeOfDay.hour}:${_timeOfDay.minute}');
              Note objectNote = Note(
                  name: controllerName.text,
                  urgency: controllerCategory.text,
                  isComplete: false,
                  dateTime: DateTime.parse(
                      dataFormaterInputUpdate(dataRecive!, _timeOfDay)),
                  payload: Routes.initial,
                  createdAt: noteObject!.createdAt);
              print(objectNote.dateTime);
              Provider.of<NotificationService>(context, listen: false)
                  .updateNote(noteObject!.key, objectNote);
              print(objectNote);
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
          style: Theme.of(context).textTheme.headline4,
        ));
  }
}
