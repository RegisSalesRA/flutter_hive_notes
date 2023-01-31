import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

dateTimeFormat(data) {
  final formattedDate = DateFormat.yMMMd().format(data);
  return formattedDate;
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

dataFormaterInput(RestorableDateTime dateTime, TimeOfDay clockTime) {
  return "${dateTime.value.year.toString()}-${monthFormat(dateTime.value.month)}-${dayFormat(dateTime.value.day)} ${minutesFormat(clockTime.hour)}:${secondsFormat(clockTime.minute)}";
}