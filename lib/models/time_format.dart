import 'package:intl/intl.dart';

class TimeFormatNow {
  static String dateFormatGAY(DateTime dateTime) {
    String date = DateFormat.MMMEd().format(dateTime);
    return date;
  }}