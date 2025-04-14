import 'package:sickness_manager/app/core/common/extensions/string_extensions.dart';

enum AbsenceStatus {
  requested,
  confirmed,
  rejected;

  String get name => toString().capitalizeFirstLetter();

  AbsenceStatus fromString(String value) {
    return AbsenceStatus.values.firstWhere(
      (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AbsenceStatus.requested,
    );
  }
}
