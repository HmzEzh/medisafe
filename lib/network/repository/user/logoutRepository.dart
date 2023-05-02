import 'package:dio/dio.dart';
import '../../api/user/logOutApi.dart';
import '../../dioException.dart';

class LogOutRepository {
  final LogOutApi logoutApi;
  LogOutRepository(this.logoutApi);

  Future<bool> logout(String deviceId) async {
    try {
      final response = await logoutApi.logOutApi(deviceId);
      return response.data as bool;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
