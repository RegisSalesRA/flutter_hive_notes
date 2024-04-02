import 'package:flutter/material.dart';
import 'package:flutter_hive/models/note.dart';

import '../../helpers/helpers.dart';
import '../../widgets/widget.dart'; 

class NoteForm extends StatefulWidget {
  final String? restorationId;
  final String? nameChange;
  final Note? noteObject;

  const NoteForm({
    super.key,
    this.nameChange,
    required this.noteObject,
    this.restorationId,
  });
  @override
  NoteFormState createState() => NoteFormState();
}

class NoteFormState extends State<NoteForm> with RestorationMixin {
  final noteFormKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCategory = TextEditingController();
  String name = "";
  DateTime? dataRecive;
  bool notificationSchedule = false;
  List<Map<String, dynamic>> noteCategory = [
    {"name": "Home"},
    {"name": "Job"},
    {"name": "Urgency"},
  ];

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          lastDate: DateTime(DateTime.now().year + 1),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        dataRecive = _selectedDate.value;
      });
    }
  }

  TimeOfDay _timeOfDay =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  void _showTimePicker() async {
    var time = await showTimePicker(
        context: context,
        initialTime: _timeOfDay,
        builder: (BuildContext context, child) {
          return Theme(
              data: ThemeData(
                primaryColor: Theme.of(context).primaryColor,
                colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.blue)
                    .copyWith(secondary: Theme.of(context).primaryColor),
              ),
              child: child!);
        });
    if (time != null) {
      setState(() {
        _timeOfDay = time;
      });
    }
  }

  @override
  void initState() {
    if (widget.noteObject != null) {
      controllerName.text = widget.noteObject!.name;
      controllerCategory.text = widget.noteObject!.urgency;
      _timeOfDay = timeOfDayFormat(widget.noteObject!.dateTime);
      dataRecive = widget.noteObject!.dateTime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          widgetAction: const SizedBox(),
          automaticallyImplyLeading: true,
          title: widget.noteObject == null ? "Create note" : "Update note",
        ),
        body: Center(
          child: Container(
            width: MediaQuerySize.widthSize(context) * 0.95,
            height: MediaQuerySize.heigthSize(context) * 0.95,
            padding: const EdgeInsets.all(5),
            child: Form(
                key: noteFormKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    InputText(
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
                      height: 15,
                    ),
                    DropDownWidget(
                      hint: SizedBox(
                        width: 100,
                        child: Text(
                          widget.noteObject == null
                              ? "Select Option"
                              : widget.noteObject!.urgency,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      dropdownItens: noteCategory.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val["name"],
                            child: SizedBox(
                                width: 100,
                                child: Text(
                                  val["name"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                )),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        controllerCategory.text = value!;
                      },
                      validator: (value) {
                        if (controllerCategory.text.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Center(
                        child: Text(
                      "Want to schedule a notification?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    const SizedBox(
                      height: 25,
                    ),
                    ToogleWidget(
                      notificationSchedule: notificationSchedule,
                      onTap1: () => setState(
                        () {
                          notificationSchedule = !notificationSchedule;
                        },
                      ),
                      onTap2: () => setState(() {
                        notificationSchedule = !notificationSchedule;
                      }),
                    ),
                    if (!notificationSchedule == false) ...{
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => _restorableDatePickerRouteFuture.present(),
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child:
                                      Text(dateTimeFormat(_selectedDate.value),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ))),
                              const Icon(Icons.dataset),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showTimePicker(),
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(hourTimeFormat(_timeOfDay),
                                    style: const TextStyle(
                                      fontSize: 18,
                                    )),
                              ),
                              const Icon(Icons.timer),
                            ],
                          ),
                        ),
                      )
                    },
                    const SizedBox(
                      height: 60,
                    ),
                    if (widget.noteObject == null)
                      CreateNoteButtonWidget(
                          selectedDate: _selectedDate,
                          timeOfDay: _timeOfDay,
                          noteFormKey: noteFormKey,
                          notificationSchedule: notificationSchedule,
                          controllerName: controllerName,
                          controllerCategory: controllerCategory),
                    if (widget.noteObject != null)
                      UpdateNotebuttonWidget(
                          selectedDate: _selectedDate,
                          timeOfDay: _timeOfDay,
                          dataRecive: dataRecive,
                          noteFormKey: noteFormKey,
                          notificationSchedule: notificationSchedule,
                          controllerName: controllerName,
                          controllerCategory: controllerCategory,
                          noteObject: widget.noteObject!),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
