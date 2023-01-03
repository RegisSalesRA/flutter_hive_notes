import 'package:intl/intl.dart';

dateTimeFormat(data) {
  final formattedDate = DateFormat.yMMMd().format(data);
  return formattedDate;
}
