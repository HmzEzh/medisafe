import 'package:intl/intl.dart';

class Utils {
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
  static String formatTime(DateTime time) => DateFormat.Hm().format(time);
  static formatDate2(DateTime date) => DateFormat.yMMMd().format(date);
}
