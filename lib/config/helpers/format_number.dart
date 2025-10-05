import 'package:intl/intl.dart';

class FormatNumber {
  static String short(double number, [int decimals = 0]) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en',
    ).format(number);
    return formattedNumber;
  }
}
