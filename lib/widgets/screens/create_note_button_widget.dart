import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.dart';
import '../../models/note.dart';
import '../../routes/routes.dart';
import '../../services/notification/notification_service.dart';
import '../widget.dart';

class CreateNoteButtonWidget extends StatelessWidget {
  const CreateNoteButtonWidget({
    Key? key,
    required RestorableDateTime selectedDate,
    required TimeOfDay timeOfDay,
    required this.noteFormKey,
    required this.notificationSchedule,
    required this.controllerName,
    required this.controllerCategory,
  })  : _selectedDate = selectedDate,
        _timeOfDay = timeOfDay,
        super(key: key);

  final RestorableDateTime _selectedDate;
  final TimeOfDay _timeOfDay;
  final GlobalKey<FormState> noteFormKey;
  final bool notificationSchedule;
  final TextEditingController controllerName;
  final TextEditingController controllerCategory;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          print(controllerName.text);
          var atualDate = DateTime.now();
          var dataChose =
              DateTime.parse(dataFormaterInput(_selectedDate, _timeOfDay));
          if (noteFormKey.currentState!.validate()) {
            if (notificationSchedule == false) {
              Note objectNote = Note(
                  name: controllerName.text,
                  urgency: controllerCategory.text,
                  isComplete: false,
                  dateTime: DateTime.parse(
                      dataFormaterInput(_selectedDate, _timeOfDay)),
                  payload: Routes.initial,
                  createdAt: DateTime.now());
              Provider.of<NotificationService>(context, listen: false)
                  .insertNote(objectNote);
              Navigator.of(context).pushNamed(Routes.initial);
              return;
            }
            if (notificationSchedule == true && dataChose.isAfter(atualDate)) {
              Note objectNote = Note(
                  name: controllerName.text,
                  urgency: controllerCategory.text,
                  isComplete: false,
                  dateTime: DateTime.parse(
                      dataFormaterInput(_selectedDate, _timeOfDay)),
                  payload: Routes.initial,
                  createdAt: DateTime.now());
              Provider.of<NotificationService>(context, listen: false)
                  .insertNote(objectNote);
              snackBarWidget(context, 'Note created with success');
              Navigator.of(context).pushNamed(Routes.initial);
              return;
            } else {
              snackBarWidget(
                  context, 'you need to choose a time above the current one');
              return;
            }
          }
        },
        child: Text(
          "Create note",
          style: Theme.of(context).textTheme.headline4,
        ));
  }
}
