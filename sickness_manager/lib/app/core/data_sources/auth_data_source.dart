import 'package:sickness_manager/app/core/common/statics.dart';
import 'package:sickness_manager/app/core/common/types/result.dart';
import 'package:sickness_manager/app/domain/data_sources/auth_data_source.dart';
import 'package:dio/dio.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final _dio = Dio();

  @override
  Future<Result<String?>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        Statics.loginApi,
        data: {'username': username, 'password': password},
        options: Options(
          validateStatus: (status) {
            return status != null && status >= 200 && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final token = response.data['access_token'];

        return Success(token);
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
