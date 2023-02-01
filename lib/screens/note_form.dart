import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import '../config/colors.dart';
import '../data/notification/notification_service.dart';
import '../helpers/helpers.dart';
import '../models/note.dart';
import '../routes/routes.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/dropdown_widget.dart';
import '../widgets/input_text.dart';

class NoteForm extends StatefulWidget {
  final String? restorationId;
  final int? indexValue;
  final String? nameChange;
  final Note? noteObject;

  NoteForm({
    Key? key,
    this.nameChange,
    required this.indexValue,
    required this.noteObject,
    this.restorationId,
  }) : super(key: key);
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> with RestorationMixin {
  final noteFormKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCategory = TextEditingController();
  String name = "";
  List<Map<String, dynamic>> noteCategory = [
    {"name": "Home"},
    {"name": "Job"},
    {"name": "Urgency"},
  ];

  Future<void> _setupTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

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
    _setupTimeZone();
    if (widget.noteObject != null) {
      controllerName.text = widget.noteObject!.name;
      controllerCategory.text = widget.noteObject!.urgency;
      _timeOfDay = timeOfDayFormat(widget.noteObject!.dateTime);
      // _selectedDate.value =
      //   dateTimeRestorableFormat(widget.noteObject!.dateTime);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationService>(context);
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
                      height: 60,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _selectedDate == null
                                ? Text("Chose a date")
                                : Text(_selectedDate.value.toString()),
                            IconButton(
                              onPressed: () {
                                _restorableDatePickerRouteFuture.present();
                              },
                              icon: Icon(Icons.dataset),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _timeOfDay == null
                                ? Text("Chose a hour")
                                : Text(_timeOfDay.toString()),
                            IconButton(
                              onPressed: () {
                                _showTimePicker();
                              },
                              icon: Icon(Icons.timer),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(widget.indexValue.toString()),
                    ElevatedButton(
                        onPressed: () {
                          if (noteFormKey.currentState!.validate()) {
                            if (widget.noteObject == null) {
                              Note objectNote = Note(
                                  name: name,
                                  urgency: controllerCategory.text,
                                  isComplete: false,
                                  payload: '/schdule',
                                  dateTime: DateTime.parse(dataFormaterInput(
                                      _selectedDate, _timeOfDay)),
                                  createdAt: DateTime.now());
                              Provider.of<NotificationService>(context,
                                      listen: false)
                                  .insertNote(objectNote);
                              Provider.of<NotificationService>(context,
                                      listen: false)
                                  .showNotification(
                                      provider.listScheduleProvider);
                              Navigator.of(context).pushNamed(Routes.initial);
                            }
                            if ((widget.noteObject != null)) {
                              Note objectNote = Note(
                                  name: controllerName.text,
                                  urgency: controllerCategory.text,
                                  isComplete: false,
                                  payload: '/schdule',
                                  dateTime: DateTime.parse(dataFormaterInput(
                                      _selectedDate, _timeOfDay)),
                                  createdAt: widget.noteObject!.createdAt);
                              Provider.of<NotificationService>(context,
                                      listen: false)
                                  .updateNote(widget.indexValue,
                                      widget.noteObject!.key, objectNote);
                              Provider.of<NotificationService>(context,
                                      listen: false)
                                  .showNotification(
                                      provider.listScheduleProvider);
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
