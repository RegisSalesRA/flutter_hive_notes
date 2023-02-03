import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/colors.dart';
import '../data/notification/notification_service.dart';
import '../helpers/helpers.dart';
import '../models/note.dart';
import '../routes/routes.dart';
import '../widgets/widget.dart';

class NoteForm extends StatefulWidget {
  final String? restorationId;
  final String? nameChange;
  final Note? noteObject;

  NoteForm({
    Key? key,
    this.nameChange,
    required this.noteObject,
    this.restorationId,
  }) : super(key: key);
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> with RestorationMixin {
  late Timer _timer;
  final noteFormKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCategory = TextEditingController();
  String name = "";
  bool notificationSchedule = false;
  List<Map<String, dynamic>> noteCategory = [
    {"name": "Home"},
    {"name": "Job"},
    {"name": "Urgency"},
  ];

  @override
  String? get restorationId => widget.restorationId;

  RestorableDateTime _selectedDate = RestorableDateTime(
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
      });
      print(_selectedDate.value);
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
                        primarySwatch: ColorsTheme.themeColor)
                    .copyWith(secondary: Theme.of(context).primaryColor),
              ),
              child: child!);
        });
    if (time != null) {
      setState(() {
        _timeOfDay = time;
      });
      print(_timeOfDay);
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(
        const Duration(milliseconds: 500), (timer) => setState(() {}));
    if (widget.noteObject != null) {
      controllerName.text = widget.noteObject!.name;
      controllerCategory.text = widget.noteObject!.urgency;
      _timeOfDay = timeOfDayFormat(widget.noteObject!.dateTime);
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          widgetAction: SizedBox(),
          automaticallyImplyLeading: true,
          title: widget.noteObject == null ? "Create note" : "Update note",
        ),
        body: Center(
          child: Container(
            width: MediaQuerySize.widthSize(context) * 0.95,
            height: MediaQuerySize.heigthSize(context) * 0.95,
            padding: EdgeInsets.all(5),
            child: Form(
                key: noteFormKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
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
                    SizedBox(
                      height: 15,
                    ),
                    DropDownWidget(
                      hint: SizedBox(
                        width: 100,
                        child: Text(
                          widget.noteObject == null
                              ? "Select Option"
                              : widget.noteObject!.urgency,
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade600),
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
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade600),
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
                    SizedBox(
                      height: 25,
                    ),
                    //Switch Button
                    Center(
                        child: Text(
                      "Deseja agendar uma notificação?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(
                      height: 25,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                        onTap: () => setState(() {
                          notificationSchedule = !notificationSchedule;
                        }),
                        child: Container(
                            height: 50,
                            width: 140,
                            decoration: BoxDecoration(
                                color: notificationSchedule == true
                                    ? ColorsTheme.primaryColor
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: Center(
                                child: Text(
                              "Sim",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          notificationSchedule = !notificationSchedule;
                        }),
                        child: Container(
                            height: 50,
                            width: 140,
                            decoration: BoxDecoration(
                                color: notificationSchedule == false
                                    ? ColorsTheme.primaryColor
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Center(
                                child: Text(
                              "Nao",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                    ]),

                    if (!notificationSchedule == false) ...{
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(color: Colors.grey.shade200, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_selectedDate == null)
                              Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text("Chose a date",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey.shade600)))
                            else
                              Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                      dateTimeFormat(_selectedDate.value),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey.shade600))),
                            IconButton(
                              onPressed: () {
                                _restorableDatePickerRouteFuture.present();
                              },
                              icon: Icon(Icons.dataset),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(color: Colors.grey.shade200, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_timeOfDay == null)
                              Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text("Chose a hour",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey.shade600)))
                            else
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(hourTimeFormat(_timeOfDay),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade600)),
                              ),
                            IconButton(
                              onPressed: () {
                                _showTimePicker();
                              },
                              icon: Icon(Icons.timer),
                            )
                          ],
                        ),
                      ),
                    },

                    SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (noteFormKey.currentState!.validate()) {
                            if (widget.noteObject == null) {
                              Note objectNote = Note(
                                  name: name,
                                  urgency: controllerCategory.text,
                                  isComplete: false,
                                  dateTime: DateTime.parse(dataFormaterInput(
                                      _selectedDate, _timeOfDay)),
                                  payload: '/notificacao',
                                  createdAt: DateTime.now());
                              Provider.of<NotificationService>(context,
                                      listen: false)
                                  .insertNote(objectNote);

                              print("aqui oh");
                              Navigator.of(context).pushNamed(Routes.initial);
                            }
                            if ((widget.noteObject != null)) {
                              Note objectNote = Note(
                                  name: controllerName.text,
                                  urgency: controllerCategory.text,
                                  isComplete: false,
                                  dateTime: DateTime.parse(dataFormaterInput(
                                      _selectedDate, _timeOfDay)),
                                  payload: '/notificacao',
                                  createdAt: widget.noteObject!.createdAt);
                              Provider.of<NotificationService>(context,
                                      listen: false)
                                  .updateNote(
                                      widget.noteObject!.key, objectNote);
                              Navigator.of(context).pushNamed(Routes.initial);
                            }
                          }
                        },
                        child: Text(
                          widget.noteObject == null
                              ? "Create note"
                              : "Update note",
                          style: Theme.of(context).textTheme.headline4,
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
