import 'package:intl/intl.dart';

class FormatDate {
  static String getCurrentDay() {
    final today = DateTime.now();
    final formattedDay = DateFormat('EEEE d').format(today);
    return formattedDay;
  }
}
