import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

Color timeDataExpired(dateTime) {
  var color;
  if (dateTime.isAfter(tz.TZDateTime.from(DateTime.now(), tz.local))) {
    color = Color(0xFFa0aefc);
  }
  if (dateTime.isBefore(tz.TZDateTime.from(DateTime.now(), tz.local))) {
    color = Colors.grey.shade300;
  }
  return color;
}

TimeOfDay timeOfDayFormat(var value) {
  TimeOfDay timeOfDayObject = TimeOfDay(hour: value.hour, minute: value.minute);
  return timeOfDayObject;
}

DateTime dateTimeRestorableFormat(var value) {
  DateTime dateTimeObject = DateTime(value.year, value.month, value.day);
  return dateTimeObject;
}

String dateTimeFormat(data) {
  final formattedDate = DateFormat.yMMMd().format(data);
  return formattedDate;
}

String hourTimeFormat(TimeOfDay value) {
  String newValue = "${hoursFormat(value.hour)}:${minutesFormat(value.minute)}";
  return newValue;
}

String monthFormat(int month) {
  late String formatedMonth;
  if (month < 10) {
    formatedMonth = '0$month';
  } else {
    formatedMonth = '$month';
  }
  return formatedMonth;
}

String dayFormat(int day) {
  late String formatedDay;
  if (day < 10) {
    formatedDay = '0$day';
  } else {
    formatedDay = '$day';
  }
  return formatedDay;
}

String hoursFormat(int minute) {
  late String formatedMinute;
  if (minute < 10) {
    formatedMinute = '0$minute';
  } else {
    formatedMinute = '$minute';
  }
  return formatedMinute;
}

String minutesFormat(int minute) {
  late String formatedMinute;
  if (minute < 10) {
    formatedMinute = '0$minute';
  } else {
    formatedMinute = '$minute';
  }
  return formatedMinute;
}

String secondsFormat(int second) {
  late String formatedSsecond;
  if (second < 10) {
    formatedSsecond = '0$second';
  } else {
    formatedSsecond = '$second';
  }
  return formatedSsecond;
}

String dataFormaterInput(RestorableDateTime dateTime, TimeOfDay clockTime) {
  return "${dateTime.value.year.toString()}-${monthFormat(dateTime.value.month)}-${dayFormat(dateTime.value.day)} ${minutesFormat(clockTime.hour)}:${secondsFormat(clockTime.minute)}";
}
