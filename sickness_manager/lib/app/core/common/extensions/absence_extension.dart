import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';

extension AbsenceExtension on Absence {
  Future<File> convertToICalFormat() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/absence_$id.ics');

    final icsContent = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//YourCompany//NONSGML Absence Event//EN
BEGIN:VEVENT
UID:$id@yourdomain.com
DTSTAMP:${DateTime.now().toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').replaceAll('.', '')}Z
DTSTART:${startDate.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').replaceAll('.', '')}Z
DTEND:${endDate.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').replaceAll('.', '')}Z
SUMMARY:Absence - ${absenceType?.name ?? 'Unknown'}
LOCATION:-
DESCRIPTION:Admitter Note: ${admitterNote ?? 'N/A'}\nMember Note: ${memberNote ?? 'N/A'}
STATUS:${status?.name ?? 'Requested'}
SEQUENCE:0
BEGIN:VALARM
TRIGGER:-PT15M
DESCRIPTION:Reminder for Absence
ACTION:DISPLAY
END:VALARM
END:VEVENT
END:VCALENDAR
''';

    await file.writeAsString(icsContent);

    return file;
  }

  Future<void> shareICallFile() async {
    try {
      final file = await convertToICalFormat();

      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Absence details for $id');
    } catch (_) {}
  }
}
