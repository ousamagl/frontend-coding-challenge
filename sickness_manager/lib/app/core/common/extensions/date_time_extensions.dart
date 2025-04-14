import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }

  String toShortDate() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toDayMonth() {
    return DateFormat('MMM dd').format(this);
  }
}
