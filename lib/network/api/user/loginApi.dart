import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'dart:io';
import '../../dioClient.dart';
import '../Endpoints.dart';

class LogInApi {
  final DioClient dioClient;

  LogInApi({required this.dioClient});
  Future<Response> logInApi(String email, String password) async {
    try {
      print(await PlatformDeviceId.getDeviceId ?? '');
      final Response response = await dioClient.post(
        Endpoints.login,
        data: {
          "email": email,
          "password": password,
          "imei": "${(await PlatformDeviceId.getDeviceId ?? '')}",
         
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  
}
