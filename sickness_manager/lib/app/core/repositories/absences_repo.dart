import 'package:sickness_manager/app/domain/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/domain/repositories/absences_repo.dart';

class AbsencesRepoImpl implements AbsencesRepo {
  AbsencesRepoImpl({required this.absencesDataSource});

  final AbsencesDataSource absencesDataSource;
}
