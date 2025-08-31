import 'package:intl/intl.dart';

class FormatNumber {
  static String short(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(number);
    return formattedNumber;
  }
}
