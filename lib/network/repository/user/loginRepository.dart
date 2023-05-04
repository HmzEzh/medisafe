import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../../../models/Users/user.dart';
import '../../api/user/loginApi.dart';
import '../../dioException.dart';

class LogInRepository {
  final LogInApi loginApi;
  final storage = const FlutterSecureStorage();

  LogInRepository(this.loginApi);
  Future<Map> getUserRequested(String email, String password) async {
    try {
      final response = await loginApi.logInApi(
        email,
        password,
      );
      storeToken((await PlatformDeviceId.getDeviceId ?? ''));
      return response.data;
    } on DioError catch (e) {
      final errorMessage = DioExceptions(e, e.response!.data["message"]);
      print(errorMessage.message);

      throw errorMessage;
    }
  }

  storeToken(String? token) async {
    if (token == null) return;
    await storage.write(key: 'token', value: token);
  }
}
