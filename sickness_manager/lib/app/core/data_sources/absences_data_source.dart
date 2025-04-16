import 'package:dio/dio.dart';
import 'package:sickness_manager/app/core/common/enums.dart';
import 'package:sickness_manager/app/core/common/statics.dart';
import 'package:sickness_manager/app/core/common/types/result.dart';
import 'package:sickness_manager/app/domain/data_sources/absences_data_source.dart';
import 'package:sickness_manager/app/domain/frameworks/storage.dart';
import 'package:sickness_manager/app/domain/models/absence.dart';
import 'package:sickness_manager/app/domain/models/member.dart';

class AbsencesDataSourceImpl implements AbsencesDataSource {
  AbsencesDataSourceImpl({required this.storage});

  final _dio = Dio();

  final Storage storage;

  @override
  Future<Result<List<Absence?>>> getAbsences({
    int offset = 0,
    int limit = 10,
    AbsenceType? type,
    AbsenceStatus? status,
    int? memberId,
    int? crewId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final token = await storage.getString(Statics.tokenKey);
      final formattedStartDate = startDate?.toIso8601String().split('T').first;
      final formattedEndDate = endDate?.toIso8601String().split('T').first;

      final queryParameters = {
        'skip': '$offset',
        'limit': '$limit',
        if (type != null && type != AbsenceType.none) 'type': type.name,
        if (status != null && status != AbsenceStatus.none)
          'status': status.name,
        if (memberId != null && memberId != -1) 'user_id': memberId.toString(),
        if (crewId != null && crewId != -1) 'crew_id': crewId.toString(),
        if (startDate != null) 'start_date': formattedStartDate,
        if (endDate != null) 'end_date': formattedEndDate,
      };

      final queryString = Uri(queryParameters: queryParameters).query;

      final response = await _dio.get(
        '${Statics.absencesApi}?$queryString',

        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) {
            return status != null && status >= 200 && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final absences =
            (response.data as List)
                .map((absence) => Absence.fromJson(absence))
                .toList();

        return Success(absences);
      } else {
        final error = response.data['detail'];
        return Failure(error);
      }
    } catch (e) {
      if (e is DioException) {
        final error = e.response?.data['detail'] ?? 'Something went wrong';
        return Failure(error);
      }

      return Failure('Something went wrong');
    }
  }

  @override
  Future<int> getAbsencesCount() async {
    try {
      final token = await storage.getString(Statics.tokenKey);
      final response = await _dio.get(
        Statics.absencesCountApi,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) {
            return status != null && status >= 200 && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['total_absences'] as int;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<Result<List<Member?>>> getMembers() async {
    try {
      final token = await storage.getString(Statics.tokenKey);
      final response = await _dio.get(
        Statics.membersApi,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) {
            return status != null && status >= 200 && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final members =
            (response.data as List)
                .map((member) => Member.fromJson(member))
                .toList();

        return Success(members);
      } else {
        final error = response.data['detail'];
        return Failure(error);
      }
    } catch (e) {
      if (e is DioException) {
        final error = e.response?.data['detail'] ?? 'Something went wrong';
        return Failure(error);
      }

      return Failure('Something went wrong');
    }
  }
}
