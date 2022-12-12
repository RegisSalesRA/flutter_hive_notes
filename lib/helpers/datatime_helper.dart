import 'package:intl/intl.dart';

dateTimeFormat(data) {
  final formatter = DateFormat('dd-MM-yyyy');
  String formattedDate = formatter.format(data);
  return formattedDate;
}
