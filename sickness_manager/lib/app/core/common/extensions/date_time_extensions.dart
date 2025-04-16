import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toShortDate() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toDayMonthYear() {
    return DateFormat('MMM dd, yy').format(this);
  }
}
