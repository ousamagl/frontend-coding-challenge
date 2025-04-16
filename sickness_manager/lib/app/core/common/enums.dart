import 'package:sickness_manager/app/core/common/extensions/string_extensions.dart';

enum AbsenceStatus {
  none,
  requested,
  confirmed,
  rejected;

  String get displayName => toString().split('.').last.capitalizeFirstLetter();

  static AbsenceStatus fromString(String value) {
    return AbsenceStatus.values.firstWhere(
      (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AbsenceStatus.none,
    );
  }
}

enum AbsenceType {
  none,
  sickness,
  vacation;

  String get displayName => toString().split('.').last.capitalizeFirstLetter();

  static AbsenceType fromString(String value) {
    return AbsenceType.values.firstWhere(
      (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AbsenceType.none,
    );
  }
}
